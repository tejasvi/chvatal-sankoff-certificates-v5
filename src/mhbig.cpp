// mhbig.cpp: in-memory pipeline for large h (no table files): BFS -> sorted keys -> CSR -> power iteration for
// several z, with vector checkpoints.  Same automaton code as mh.cpp (mh_delta.h).
//
//   mhbig H OUTDIR ZLIST ITERS TOL [PREV_KEYS PREV_V]
//     ZLIST     comma-separated z values (the table is built once)
//     PREV_*    keys/vector of level H-1 (optional): initial vector by projection (drop the oldest bit of x,y,dx,dy)
//   env MH_CAPLOG2 (hash capacity, log2), MH_BETA (momentum coefficient as a fraction of lambda^2, default 0)
// Writes OUTDIR/h<H>_keys.bin (sorted uint64) and OUTDIR/h<H>_v_<z>.bin (doubles, same order), checkpointed.
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
#include <parallel/algorithm>
#include "mh_delta.h"

static const uint64_t EMPTY = ~0ULL;
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

int main(int argc, char **argv) {
    if (argc < 6) { fprintf(stderr, "usage: mhbig H OUTDIR ZLIST ITERS TOL [PREV_KEYS PREV_V]\n"); return 1; }
    int h = atoi(argv[1]); std::string out = argv[2];
    std::vector<double> zs; { std::string s = argv[3]; size_t p = 0; while (p < s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); zs.push_back(atof(s.substr(p, q - p).c_str())); p = q + 1; } }
    int iters = atoi(argv[4]); double tol = atof(argv[5]);
    signal(SIGTERM, on_term); signal(SIGINT, on_term);
    const int L = 2 * h - 1, NI = 2 * L;
    double t0 = now();
    int caplog = getenv("MH_CAPLOG2") ? atoi(getenv("MH_CAPLOG2")) : 0;
    double est[16] = {0, 0, 7, 98, 1020, 10160, 89960, 780368, 6419109, 51425006, 400253317, 3.2e9, 2.5e10, 0, 0, 0};
    uint64_t cap = 1ULL << 10; if (caplog) cap = 1ULL << caplog; else while (cap < (uint64_t)(est[h] * 1.45) + 1024) cap <<= 1;
    const uint64_t maskc = cap - 1;
    uint64_t *slot = (uint64_t *)malloc(cap * 8); if (!slot) { fprintf(stderr, "malloc hash\n"); return 1; }
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < cap; i++) slot[i] = EMPTY;
    auto insert = [&](uint64_t k) -> bool {
        uint64_t i = mix64(k) & maskc;
        while (true) {
            uint64_t cur = __atomic_load_n(&slot[i], __ATOMIC_RELAXED);
            if (cur == k) return false;
            if (cur == EMPTY) {
                uint64_t e = EMPTY;
                if (__atomic_compare_exchange_n(&slot[i], &e, k, false, __ATOMIC_RELAXED, __ATOMIC_RELAXED)) return true;
                if (e == k) return false;
            }
            i = (i + 1) & maskc;
        }
    };
    auto find = [&](uint64_t k) -> uint64_t {
        uint64_t i = mix64(k) & maskc;
        while (true) { uint64_t cur = slot[i]; if (cur == k) return i; if (cur == EMPTY) return EMPTY; i = (i + 1) & maskc; }
    };
    fprintf(stderr, "h=%d hash capacity 2^%d (%.1f GB), threads %d\n", h, __builtin_ctzll(cap), cap * 8e-9, omp_get_max_threads());
    // ---- BFS
    std::vector<uint64_t> frontier, next;
    uint64_t q0 = (((1ULL << h) - 1) << h) | ((1ULL << h) - 1);
    insert(q0); frontier.push_back(q0);
    uint64_t total = 1; int nth = omp_get_max_threads();
    while (!frontier.empty()) {
        std::vector<std::vector<uint64_t>> loc(nth);
#pragma omp parallel
        {
            std::vector<uint64_t> &mine = loc[omp_get_thread_num()];
#pragma omp for schedule(dynamic, 1024)
            for (size_t i = 0; i < frontier.size(); i++)
                for (int c = 0; c < 2; c++)
                    for (int l = -(h - 1); l <= h - 1; l++) {
                        uint64_t t = delta_dp(h, frontier[i], c, l);
                        if (t != REJECT && insert(t)) mine.push_back(t);
                    }
        }
        size_t tot = 0; for (auto &v : loc) tot += v.size();
        next.clear(); next.reserve(tot);
        for (auto &v : loc) { next.insert(next.end(), v.begin(), v.end()); std::vector<uint64_t>().swap(v); }
        total += next.size();
        fprintf(stderr, "  frontier %zu new %zu total %llu (%.0fs)\n", frontier.size(), next.size(), (unsigned long long)total, now() - t0);
        frontier.swap(next);
        if (total * 10 > cap * 7) { fprintf(stderr, "hash too full\n"); return 1; }
        if (g_stop) { fprintf(stderr, "stopped during BFS\n"); return 3; }
    }
    std::vector<uint64_t>().swap(frontier); std::vector<uint64_t>().swap(next);
    std::vector<uint64_t> keys; keys.reserve(total);
    for (uint64_t i = 0; i < cap; i++) if (slot[i] != EMPTY) keys.push_back(slot[i]);
    __gnu_parallel::sort(keys.begin(), keys.end());
    const uint64_t N = keys.size();
    if (N >= 0xFFFFFFFFULL) { fprintf(stderr, "too many states for uint32\n"); return 1; }
    fprintf(stderr, "h=%d states=%llu (%.0fs)\n", h, (unsigned long long)N, now() - t0);
    write_file(out + "/h" + std::to_string(h) + "_keys.bin", keys.data(), N * 8);
    uint32_t *rank = (uint32_t *)malloc(cap * 4);
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < N; i++) rank[find(keys[i])] = (uint32_t)i;
    // ---- masks and block offsets (every 64 states)
    std::vector<uint64_t> mask(N);
#pragma omp parallel for schedule(dynamic, 4096)
    for (uint64_t i = 0; i < N; i++) {
        uint64_t m = 0;
        for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++)
            if (delta_dp(h, keys[i], c, l) != REJECT) m |= 1ULL << (c * L + l + h - 1);
        mask[i] = m;
    }
    const uint64_t NB = (N + 63) / 64;
    std::vector<uint64_t> boff(NB + 1); boff[0] = 0;
    for (uint64_t b = 0; b < NB; b++) {
        uint64_t s = 0; for (uint64_t i = b * 64; i < std::min(N, b * 64 + 64); i++) s += __builtin_popcountll(mask[i]);
        boff[b + 1] = boff[b] + s;
    }
    const uint64_t E = boff[NB];
    uint32_t *succ = (uint32_t *)malloc(E * 4 + 4); if (!succ) { fprintf(stderr, "malloc succ\n"); return 1; }
    uint64_t bad = 0;
#pragma omp parallel for schedule(dynamic, 64) reduction(+:bad)
    for (uint64_t b = 0; b < NB; b++) {
        uint64_t p = boff[b];
        for (uint64_t i = b * 64; i < std::min(N, b * 64 + 64); i++)
            for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++) {
                uint64_t t = delta_dp(h, keys[i], c, l);
                if (t == REJECT) continue;
                uint64_t sl = find(t); if (sl == EMPTY) { bad++; succ[p++] = 0; continue; }
                succ[p++] = rank[sl];
            }
    }
    if (bad) { fprintf(stderr, "closure failure %llu\n", (unsigned long long)bad); return 1; }
    free(rank); free(slot);
    fprintf(stderr, "edges=%llu, table built (%.0fs)\n", (unsigned long long)E, now() - t0);
    // ---- initial vector
    std::vector<double> v(N, 1.0), vn(N), vp;
    if (argc >= 8) {
        size_t sk, sv; uint64_t *Kp = (uint64_t *)read_file(argv[6], &sk); double *Vp = (double *)read_file(argv[7], &sv);
        uint64_t Np = sk / 8; if (sv != Np * 8) { fprintf(stderr, "bad prev\n"); return 1; }
        double vmin = 1e300; for (uint64_t i = 0; i < Np; i++) vmin = std::min(vmin, Vp[i]);
        const int g = h - 1; const uint64_t Mg = (1ULL << g) - 1, Mh = (1ULL << h) - 1; uint64_t found = 0;
#pragma omp parallel for schedule(static) reduction(+:found)
        for (uint64_t i = 0; i < N; i++) {
            uint64_t k = keys[i];
            uint64_t x = (k >> (3 * h)) & Mh & Mg, y = (k >> (2 * h)) & Mh & Mg, dx = (k >> h) & Mg, dy = k & Mg;
            if ((x >> (g - 1)) & 1) { x ^= Mg; y ^= Mg; }
            uint64_t kp = (x << (3 * g)) | (y << (2 * g)) | (dx << g) | dy;
            const uint64_t *p = std::lower_bound(Kp, Kp + Np, kp);
            if (p != Kp + Np && *p == kp) { v[i] = Vp[p - Kp]; found++; } else v[i] = vmin;
        }
        free(Kp); free(Vp);
        fprintf(stderr, "lifted initial vector: %llu of %llu states found at level %d\n", (unsigned long long)found, (unsigned long long)N, g);
    }
    double betafrac = getenv("MH_BETA") ? atof(getenv("MH_BETA")) : 0.0;
    if (betafrac > 0) vp.assign(N, 0.0);
    // ---- power iteration per z
    for (double z : zs) {
        double w[64];
        for (int t = 0; t < NI; t++) { int l = (t % L) - (h - 1), al = abs(l); w[t] = (al < h - 1) ? pow(z, al + 2) : pow(z, h + 1) / (1 - z); }
        char zb[64]; snprintf(zb, sizeof zb, "%.6f", z);
        std::string vpath = out + "/h" + std::to_string(h) + "_v_" + zb + ".bin";
        double rmin = 0, rmax = 0, lamest = 0, te = now();
        if (betafrac > 0) std::fill(vp.begin(), vp.end(), 0.0);
        for (int it = 1; it <= iters; it++) {
            double mx = 0; rmin = 1e300; rmax = 0;
#pragma omp parallel for schedule(dynamic, 16) reduction(max:mx, rmax) reduction(min:rmin)
            for (uint64_t b = 0; b < NB; b++) {
                uint64_t p = boff[b];
                for (uint64_t i = b * 64; i < std::min(N, b * 64 + 64); i++) {
                    uint64_t m = mask[i]; double s = 0;
                    while (m) { int t = __builtin_ctzll(m); m &= m - 1; s += w[t] * v[succ[p++]]; }
                    double r = s / v[i];
                    if (r > rmax) rmax = r; if (r < rmin) rmin = r;
                    vn[i] = s;
                }
            }
            lamest = 0.5 * (rmin + rmax);
            if (betafrac > 0) {
                double beta = betafrac * lamest * lamest;
#pragma omp parallel for schedule(static) reduction(max:mx)
                for (uint64_t i = 0; i < N; i++) { double t = vn[i] - beta * vp[i]; vn[i] = t; if (t > mx) mx = t; }
                double inv = 1.0 / mx;
#pragma omp parallel for schedule(static)
                for (uint64_t i = 0; i < N; i++) { vp[i] = v[i] * inv; v[i] = vn[i] * inv; }
            } else {
#pragma omp parallel for schedule(static) reduction(max:mx)
                for (uint64_t i = 0; i < N; i++) if (vn[i] > mx) mx = vn[i];
                double inv = 1.0 / mx;
#pragma omp parallel for schedule(static)
                for (uint64_t i = 0; i < N; i++) v[i] = vn[i] * inv;
            }
            bool done = rmax / rmin < 1 + tol || it == iters;
            if (it % 10 == 0 || done || g_stop)
                fprintf(stderr, "  z=%s it %d: ratio in [%.15f, %.15f] gap %.3e (%.0fs)\n", zb, it, rmin, rmax, rmax / rmin - 1, now() - te);
            if (it % 50 == 0 || done || g_stop) write_file(vpath, v.data(), N * 8);
            if (done) break;
            if (g_stop) { fprintf(stderr, "stopped; vector checkpointed\n"); return 3; }
        }
        double bound = 2 * log(2 * z) / log(rmax);
        printf("h=%d z=%s N=%llu E=%llu lambda in [%.15f, %.15f] bound(rmax)=%.9f (%.0fs total)\n", h, zb,
               (unsigned long long)N, (unsigned long long)E, rmin, rmax, bound, now() - t0);
        fflush(stdout);
    }
    return 0;
}
