// mhgroup.cpp: large-h pipeline without a stored transition table.
//   mhgroup bfs   H OUTDIR                              -> OUTDIR/h<H>_keys.bin (sorted uint64 keys)
//   mhgroup eigen H OUTDIR ZLIST ITERS TOL [VINIT] [F32] -> OUTDIR/h<H>_v_<z>.bin (doubles), checkpointed
// Transitions are recomputed on the fly with the bit-parallel mh_fast.h (validated against mh_delta.h).  States are
// grouped by their string part g = key >> 2h = (x,y); all successors of a group under one input lie in one target
// group, so successor lookups are binary searches inside one small, cache-resident key range.
// env MH_CAPLOG2: hash capacity (log2) for bfs.
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <csignal>
#include <vector>
#include <string>
#include <algorithm>
#include <omp.h>
#include "mh_fast.h"

static volatile sig_atomic_t g_stop = 0;
static void on_term(int) { g_stop = 1; }
static double now() { return omp_get_wtime(); }
static inline uint64_t mix64(uint64_t z) {
    z += 0x9e3779b97f4a7c15ULL; z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL; return z ^ (z >> 31);
}
static void write_file(const std::string &path, const void *p, size_t n) {
    std::string tmp = path + ".tmp";
    FILE *f = fopen(tmp.c_str(), "wb"); if (!f) { perror(tmp.c_str()); exit(1); }
    const char *q = (const char *)p; size_t done = 0;
    while (done < n) { size_t w = fwrite(q + done, 1, std::min(n - done, (size_t)1 << 30), f); if (!w) { perror("fwrite"); exit(1); } done += w; }
    if (fclose(f)) { perror("fclose"); exit(1); }
    if (rename(tmp.c_str(), path.c_str())) { perror("rename"); exit(1); }
}
static void *read_file(const char *path, size_t *n) {
    FILE *f = fopen(path, "rb"); if (!f) { perror(path); exit(1); }
    fseek(f, 0, SEEK_END); size_t sz = ftell(f); fseek(f, 0, SEEK_SET);
    char *p = (char *)malloc(sz ? sz : 1); size_t done = 0;
    while (done < sz) { size_t r = fread(p + done, 1, std::min(sz - done, (size_t)1 << 30), f); if (!r) { perror("fread"); exit(1); } done += r; }
    fclose(f); *n = sz; return p;
}

static int cmd_bfs(int h, const std::string &out) {
    const int NI = 2 * (2 * h - 1);
    double t0 = now();
    double est[16] = {0, 0, 7, 98, 1020, 10160, 89960, 780368, 6419109, 51425006, 400253317, 3.05e9, 2.3e10, 1.7e11, 0, 0};
    int caplog = getenv("MH_CAPLOG2") ? atoi(getenv("MH_CAPLOG2")) : 0;
    uint64_t cap = 1ULL << 10; if (caplog) cap = 1ULL << caplog; else while (cap < (uint64_t)(est[h] * 1.45) + 1024) cap <<= 1;
    const uint64_t mk = cap - 1;
    uint64_t *slot = (uint64_t *)malloc(cap * 8); if (!slot) { fprintf(stderr, "malloc hash\n"); return 1; }
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < cap; i++) slot[i] = ~0ULL;
    auto insert = [&](uint64_t k) -> bool {
        uint64_t i = mix64(k) & mk;
        while (true) {
            uint64_t cur = __atomic_load_n(&slot[i], __ATOMIC_RELAXED);
            if (cur == k) return false;
            if (cur == ~0ULL) { uint64_t e = ~0ULL; if (__atomic_compare_exchange_n(&slot[i], &e, k, false, __ATOMIC_RELAXED, __ATOMIC_RELAXED)) return true; if (e == k) return false; }
            i = (i + 1) & mk;
        }
    };
    fprintf(stderr, "h=%d bfs: hash 2^%d (%.1f GB), %d threads\n", h, __builtin_ctzll(cap), cap * 8e-9, omp_get_max_threads());
    std::vector<uint64_t> frontier, next;
    uint64_t q0 = (((1ULL << h) - 1) << h) | ((1ULL << h) - 1);
    insert(q0); frontier.push_back(q0);
    uint64_t total = 1, acc = 0; int nth = omp_get_max_threads();
    while (!frontier.empty()) {
        std::vector<std::vector<uint64_t>> loc(nth);
        uint64_t a = 0;
#pragma omp parallel reduction(+:a)
        {
            std::vector<uint64_t> &mine = loc[omp_get_thread_num()];
            uint64_t o[64];
#pragma omp for schedule(dynamic, 1024)
            for (size_t i = 0; i < frontier.size(); i++) {
                fast_delta_all(h, frontier[i], o);
                for (int t = 0; t < NI; t++) if (o[t] != ~0ULL) { a++; if (insert(o[t])) mine.push_back(o[t]); }
            }
        }
        acc += a;
        size_t tot = 0; for (auto &v : loc) tot += v.size();
        next.clear(); next.reserve(tot);
        for (auto &v : loc) { next.insert(next.end(), v.begin(), v.end()); std::vector<uint64_t>().swap(v); }
        total += next.size();
        fprintf(stderr, "  frontier %zu new %zu total %llu (%.0fs)\n", frontier.size(), next.size(), (unsigned long long)total, now() - t0);
        frontier.swap(next);
        if (total * 10 > cap * 8) { fprintf(stderr, "hash too full\n"); return 1; }
    }
    std::vector<uint64_t>().swap(frontier); std::vector<uint64_t>().swap(next);
    // counting sort by group (top 2h bits), then sort inside groups
    const int GB = 2 * h; const uint64_t NG = 1ULL << GB;
    std::vector<uint64_t> cnt(NG + 1, 0);
    {
        int T = omp_get_max_threads();
        std::vector<std::vector<uint32_t>> lc(T, std::vector<uint32_t>());
        // single pass with atomics on counts
#pragma omp parallel for schedule(static)
        for (uint64_t i = 0; i < cap; i++) if (slot[i] != ~0ULL) __atomic_fetch_add(&cnt[(slot[i] >> GB) + 1], 1, __ATOMIC_RELAXED);
    }
    for (uint64_t g = 0; g < NG; g++) cnt[g + 1] += cnt[g];
    const uint64_t N = cnt[NG];
    uint64_t *keys = (uint64_t *)malloc(N * 8);
    std::vector<uint64_t> pos(cnt.begin(), cnt.end() - 1);
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < cap; i++) if (slot[i] != ~0ULL) { uint64_t p = __atomic_fetch_add(&pos[slot[i] >> GB], 1, __ATOMIC_RELAXED); keys[p] = slot[i]; }
    free(slot);
#pragma omp parallel for schedule(dynamic, 1024)
    for (uint64_t g = 0; g < NG; g++) std::sort(keys + cnt[g], keys + cnt[g + 1]);
    for (uint64_t i = 1; i < N; i++) if (keys[i] <= keys[i - 1]) { fprintf(stderr, "sort failure\n"); return 1; }
    write_file(out + "/h" + std::to_string(h) + "_keys.bin", keys, N * 8);
    printf("h=%d states=%llu accepted transitions=%llu time=%.0fs\n", h, (unsigned long long)N, (unsigned long long)acc, now() - t0);
    return 0;
}

static int cmd_eigen(int h, const std::string &out, const std::vector<double> &zs, int iters, double tol, const char *vinit, bool f32) {
    const int L = 2 * h - 1, NI = 2 * L, GB = 2 * h;
    double t0 = now(); size_t sz;
    uint64_t *keys = (uint64_t *)read_file((out + "/h" + std::to_string(h) + "_keys.bin").c_str(), &sz);
    const uint64_t N = sz / 8, NG = 1ULL << GB;
    std::vector<uint64_t> gs(NG + 1, 0);
    for (uint64_t i = 0; i < N; i++) gs[(keys[i] >> GB) + 1]++;
    for (uint64_t g = 0; g < NG; g++) gs[g + 1] += gs[g];
    // low 2h bits for in-group search (h <= 16)
    uint32_t *lo = (uint32_t *)malloc(N * 4);
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < N; i++) lo[i] = (uint32_t)(keys[i] & ((1ULL << GB) - 1));
    std::vector<uint64_t> nonempty; for (uint64_t g = 0; g < NG; g++) if (gs[g + 1] > gs[g]) nonempty.push_back(g);
    fprintf(stderr, "h=%d eigen: N=%llu groups=%zu (%.0fs)\n", h, (unsigned long long)N, nonempty.size(), now() - t0);
    double *v = (double *)malloc(N * 8), *vn = (double *)malloc(N * 8);
    if (vinit) { double *p = (double *)read_file(vinit, &sz); if (sz != N * 8) { fprintf(stderr, "bad vinit\n"); return 1; } memcpy(v, p, N * 8); free(p); }
    else for (uint64_t i = 0; i < N; i++) v[i] = 1.0;
    (void)f32;
    for (double z : zs) {
        double w[64];
        for (int t = 0; t < NI; t++) { int l = (t % L) - (h - 1), al = abs(l); w[t] = (al < h - 1) ? pow(z, al + 2) : pow(z, h + 1) / (1 - z); }
        char zb[64]; snprintf(zb, sizeof zb, "%.6f", z);
        std::string vpath = out + "/h" + std::to_string(h) + "_v_" + zb + ".bin";
        double rmin = 0, rmax = 0, te = now(); uint64_t missing = 0;
        for (int it = 1; it <= iters; it++) {
            double mx = 0; rmin = 1e300; rmax = 0;
#pragma omp parallel for schedule(dynamic, 64) reduction(max:mx, rmax) reduction(min:rmin) reduction(+:missing)
            for (size_t gi = 0; gi < nonempty.size(); gi++) {
                uint64_t g = nonempty[gi]; uint64_t o[64];
                for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
                    fast_delta_all(h, keys[i], o);
                    double s = 0;
                    for (int t = 0; t < NI; t++) {
                        uint64_t k = o[t]; if (k == ~0ULL) continue;
                        uint64_t tg = k >> GB; uint32_t kl = (uint32_t)(k & ((1ULL << GB) - 1));
                        const uint32_t *b = lo + gs[tg], *e = lo + gs[tg + 1];
                        const uint32_t *p = std::lower_bound(b, e, kl);
                        if (p == e || *p != kl) { missing++; continue; }
                        s += w[t] * v[p - lo];
                    }
                    vn[i] = s; double r = s / v[i];
                    if (s > mx) mx = s; if (r > rmax) rmax = r; if (r < rmin) rmin = r;
                }
            }
            if (missing) { fprintf(stderr, "closure failure: %llu successors not found\n", (unsigned long long)missing); return 1; }
            double inv = 1.0 / mx;
#pragma omp parallel for schedule(static)
            for (uint64_t i = 0; i < N; i++) v[i] = vn[i] * inv;
            bool done = rmax / rmin < 1 + tol || it == iters;
            if (it % 10 == 0 || done || g_stop || it <= 2)
                fprintf(stderr, "  z=%s it %d: ratio in [%.15f, %.15f] gap %.3e (%.0fs)\n", zb, it, rmin, rmax, rmax / rmin - 1, now() - te);
            if (it % 50 == 0 || done || g_stop) write_file(vpath, v, N * 8);
            if (done) break;
            if (g_stop) { fprintf(stderr, "stopped; vector checkpointed\n"); return 3; }
        }
        printf("h=%d z=%s N=%llu lambda in [%.15f, %.15f] bound(rmax)=%.9f (%.0fs total)\n", h, zb, (unsigned long long)N, rmin, rmax,
               2 * log(2 * z) / log(rmax), now() - t0);
        fflush(stdout);
    }
    return 0;
}

int main(int argc, char **argv) {
    signal(SIGTERM, on_term); signal(SIGINT, on_term);
    fast_init();
    if (argc < 4) { fprintf(stderr, "usage: see header\n"); return 1; }
    int h = atoi(argv[2]); std::string out = argv[3];
    if (h < 2 || h > 15) return 1;
    if (!strcmp(argv[1], "bfs")) return cmd_bfs(h, out);
    if (!strcmp(argv[1], "eigen")) {
        std::vector<double> zs; std::string s = argv[4]; size_t p = 0;
        while (p < s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); zs.push_back(atof(s.substr(p, q - p).c_str())); p = q + 1; }
        return cmd_eigen(h, out, zs, atoi(argv[5]), atof(argv[6]), argc > 7 && strcmp(argv[7], "-") ? argv[7] : nullptr, argc > 8);
    }
    return 1;
}
