// mh.cpp: Lueker's automaton M_h (definition in Section 3 of the paper), state enumeration by parallel BFS,
// transition table in CSR form, and power iteration for the Perron root lambda(z) of A_z.
//
//   mh build H OUTDIR [THREADS]          enumerate states, write OUTDIR/h<H>_keys.bin (sorted uint64 keys),
//                                        OUTDIR/h<H>_csr.bin (masks + successor ranks)
//   mh eigen H OUTDIR Z ITERS TOL [VIN]  power iteration on the stored table; writes OUTDIR/h<H>_v_<Z>.bin (doubles)
//
// State key: x<<(3h) | y<<(2h) | dx<<h | dy, each an h-bit string with the OLDEST entry in the most significant bit.
// Inputs T_{c,l}, c in {0,1}, l in [-(h-1), h-1]; input index t = c*(2h-1) + (l+h-1).
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <vector>
#include <algorithm>
#include <atomic>
#include <omp.h>
#include <parallel/algorithm>

static const uint64_t EMPTY = ~0ULL;

#include "mh_delta.h"

// ---------------------------------------------------------------- concurrent hash set (open addressing)
static inline uint64_t mix64(uint64_t z) {
    z += 0x9e3779b97f4a7c15ULL;
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
}
struct HashSet {
    uint64_t *slot; uint64_t cap, maskc;
    void init(uint64_t c) {
        cap = c; maskc = c - 1;
        slot = (uint64_t *)malloc(cap * sizeof(uint64_t));
        if (!slot) { fprintf(stderr, "malloc hash failed\n"); exit(1); }
#pragma omp parallel for schedule(static)
        for (uint64_t i = 0; i < cap; i++) slot[i] = EMPTY;
    }
    // returns true if newly inserted
    inline bool insert(uint64_t k) {
        uint64_t i = mix64(k) & maskc;
        while (true) {
            uint64_t cur = __atomic_load_n(&slot[i], __ATOMIC_RELAXED);
            if (cur == k) return false;
            if (cur == EMPTY) {
                uint64_t exp = EMPTY;
                if (__atomic_compare_exchange_n(&slot[i], &exp, k, false, __ATOMIC_RELAXED, __ATOMIC_RELAXED)) return true;
                if (exp == k) return false;
            }
            i = (i + 1) & maskc;
        }
    }
    inline uint64_t find(uint64_t k) const {
        uint64_t i = mix64(k) & maskc;
        while (true) {
            uint64_t cur = slot[i];
            if (cur == k) return i;
            if (cur == EMPTY) return EMPTY;
            i = (i + 1) & maskc;
        }
    }
};

static double now() { return omp_get_wtime(); }

static void write_file(const char *path, const void *p, size_t n) {
    FILE *f = fopen(path, "wb"); if (!f) { perror(path); exit(1); }
    const char *q = (const char *)p; size_t done = 0;
    while (done < n) { size_t w = fwrite(q + done, 1, std::min(n - done, (size_t)1 << 30), f); if (!w) { perror("fwrite"); exit(1); } done += w; }
    fclose(f);
}
static void *read_file(const char *path, size_t *n) {
    FILE *f = fopen(path, "rb"); if (!f) { perror(path); exit(1); }
    fseek(f, 0, SEEK_END); size_t sz = ftell(f); fseek(f, 0, SEEK_SET);
    char *p = (char *)malloc(sz ? sz : 1); size_t done = 0;
    while (done < sz) { size_t r = fread(p + done, 1, std::min(sz - done, (size_t)1 << 30), f); if (!r) { perror("fread"); exit(1); } done += r; }
    fclose(f); *n = sz; return p;
}

// ---------------------------------------------------------------- build
static int cmd_build(int h, const char *outdir) {
    const int NI = 2 * (2 * h - 1);
    double t0 = now();
    uint64_t cap = 1ULL << 10;
    double est[16] = {0, 0, 7, 98, 1020, 10160, 89960, 780368, 6419109, 51425006, 400253317, 3.2e9, 2.5e10, 0, 0, 0};
    while (cap < (uint64_t)(est[h] * 1.45) + 1024) cap <<= 1;
    HashSet H; H.init(cap);
    fprintf(stderr, "h=%d hash capacity %llu (%.1f GB)\n", h, (unsigned long long)cap, cap * 8.0 / 1e9);
    std::vector<uint64_t> frontier, next;
    uint64_t q0 = start_key(h);
    H.insert(q0); frontier.push_back(q0);
    uint64_t total = 1, level = 0, ntrans_acc = 0;
    int nth = omp_get_max_threads();
    while (!frontier.empty()) {
        std::vector<std::vector<uint64_t>> loc(nth);
        uint64_t acc = 0;
#pragma omp parallel reduction(+:acc)
        {
            int tid = omp_get_thread_num();
            std::vector<uint64_t> &mine = loc[tid];
#pragma omp for schedule(dynamic, 1024)
            for (size_t i = 0; i < frontier.size(); i++) {
                uint64_t k = frontier[i];
                for (int c = 0; c < 2; c++)
                    for (int l = -(h - 1); l <= h - 1; l++) {
                        uint64_t t = delta_dp(h, k, c, l);
                        if (t == REJECT) continue;
                        acc++;
                        if (H.insert(t)) mine.push_back(t);
                    }
            }
        }
        ntrans_acc += acc;
        next.clear();
        size_t tot = 0; for (auto &v : loc) tot += v.size();
        next.reserve(tot);
        for (auto &v : loc) { next.insert(next.end(), v.begin(), v.end()); std::vector<uint64_t>().swap(v); }
        total += next.size(); level++;
        fprintf(stderr, "  level %llu: frontier %zu new %zu total %llu (%.1fs)\n", (unsigned long long)level,
                frontier.size(), next.size(), (unsigned long long)total, now() - t0);
        frontier.swap(next);
        if (total * 10 > cap * 7) { fprintf(stderr, "hash too full\n"); exit(1); }
    }
    std::vector<uint64_t>().swap(frontier); std::vector<uint64_t>().swap(next);
    // collect and sort keys
    std::vector<uint64_t> keys; keys.reserve(total);
    for (uint64_t i = 0; i < cap; i++) if (H.slot[i] != EMPTY) keys.push_back(H.slot[i]);
    __gnu_parallel::sort(keys.begin(), keys.end());
    uint64_t N = keys.size();
    fprintf(stderr, "h=%d states=%llu accepted transitions=%llu (BFS %.1fs)\n", h, (unsigned long long)N,
            (unsigned long long)ntrans_acc, now() - t0);
    // rank map: rank stored per slot
    uint32_t *rank = (uint32_t *)malloc(cap * sizeof(uint32_t));
    if (N >= 0xFFFFFFFFULL) { fprintf(stderr, "too many states for uint32 ranks\n"); exit(1); }
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < N; i++) rank[H.find(keys[i])] = (uint32_t)i;
    // masks + counts
    std::vector<uint64_t> mask(N), off(N + 1);
#pragma omp parallel for schedule(dynamic, 4096)
    for (uint64_t i = 0; i < N; i++) {
        uint64_t m = 0;
        for (int c = 0; c < 2; c++)
            for (int l = -(h - 1); l <= h - 1; l++)
                if (delta_dp(h, keys[i], c, l) != REJECT) m |= 1ULL << (c * (2 * h - 1) + l + h - 1);
        mask[i] = m;
    }
    off[0] = 0;
    for (uint64_t i = 0; i < N; i++) off[i + 1] = off[i] + __builtin_popcountll(mask[i]);
    uint64_t E = off[N];
    uint32_t *succ = (uint32_t *)malloc(E * sizeof(uint32_t) + 4);
#pragma omp parallel for schedule(dynamic, 4096)
    for (uint64_t i = 0; i < N; i++) {
        uint64_t p = off[i];
        for (int c = 0; c < 2; c++)
            for (int l = -(h - 1); l <= h - 1; l++) {
                uint64_t t = delta_dp(h, keys[i], c, l);
                if (t == REJECT) continue;
                uint64_t sl = H.find(t);
                if (sl == EMPTY) { fprintf(stderr, "closure failure\n"); exit(1); }
                succ[p++] = rank[sl];
            }
    }
    fprintf(stderr, "edges=%llu (%.1fs)\n", (unsigned long long)E, now() - t0);
    char path[4096];
    snprintf(path, sizeof path, "%s/h%d_keys.bin", outdir, h); write_file(path, keys.data(), N * 8);
    snprintf(path, sizeof path, "%s/h%d_mask.bin", outdir, h); write_file(path, mask.data(), N * 8);
    snprintf(path, sizeof path, "%s/h%d_succ.bin", outdir, h); write_file(path, succ, E * 4);
    printf("h=%d states=%llu edges=%llu start_rank=%u time=%.1fs\n", h, (unsigned long long)N, (unsigned long long)E,
           rank[H.find(q0)], now() - t0);
    (void)NI;
    return 0;
}

// ---------------------------------------------------------------- eigen (power iteration)
static int cmd_eigen(int h, const char *outdir, double z, int iters, double tol, const char *vin) {
    char path[4096]; size_t sz;
    snprintf(path, sizeof path, "%s/h%d_mask.bin", outdir, h);
    uint64_t *mask = (uint64_t *)read_file(path, &sz); uint64_t N = sz / 8;
    snprintf(path, sizeof path, "%s/h%d_succ.bin", outdir, h);
    uint32_t *succ = (uint32_t *)read_file(path, &sz); uint64_t E = sz / 4;
    std::vector<uint64_t> off(N + 1); off[0] = 0;
    for (uint64_t i = 0; i < N; i++) off[i + 1] = off[i] + __builtin_popcountll(mask[i]);
    if (off[N] != E) { fprintf(stderr, "edge count mismatch\n"); return 1; }
    const int L = 2 * h - 1;
    double w[64];
    for (int t = 0; t < 2 * L; t++) {
        int l = (t % L) - (h - 1), al = abs(l);
        w[t] = (al < h - 1) ? pow(z, al + 2) : pow(z, h + 1) / (1 - z);
    }
    std::vector<double> v(N, 1.0), vn(N);
    if (vin) { size_t s2; double *p = (double *)read_file(vin, &s2); if (s2 != N * 8) { fprintf(stderr, "bad vin\n"); return 1; } memcpy(v.data(), p, N * 8); free(p); }
    double t0 = now(), lamhi = 0, lamlo = 0;
    for (int it = 1; it <= iters; it++) {
        double mx = 0, rmin = 1e300, rmax = 0;
#pragma omp parallel for schedule(dynamic, 8192) reduction(max:mx, rmax) reduction(min:rmin)
        for (uint64_t i = 0; i < N; i++) {
            uint64_t m = mask[i], p = off[i]; double s = 0;
            while (m) { int t = __builtin_ctzll(m); m &= m - 1; s += w[t] * v[succ[p++]]; }
            vn[i] = s; double r = s / v[i];
            if (s > mx) mx = s; if (r > rmax) rmax = r; if (r < rmin) rmin = r;
        }
        double inv = 1.0 / mx;
#pragma omp parallel for schedule(static)
        for (uint64_t i = 0; i < N; i++) v[i] = vn[i] * inv;
        lamhi = rmax; lamlo = rmin;
        if (it % 10 == 0 || rmax / rmin < 1 + tol || it == iters)
            fprintf(stderr, "  it %d: ratio in [%.15f, %.15f] gap %.3e (%.1fs)\n", it, rmin, rmax, rmax / rmin - 1, now() - t0);
        if (rmax / rmin < 1 + tol) break;
    }
    double bound = 2 * log(2 * z) / log(lamhi);
    printf("h=%d z=%.6f N=%llu lambda in [%.15f, %.15f] bound(lamhi)=%.9f\n", h, z, (unsigned long long)N, lamlo, lamhi, bound);
    snprintf(path, sizeof path, "%s/h%d_v_%.6f.bin", outdir, h, z); write_file(path, v.data(), N * 8);
    return 0;
}


// ---------------------------------------------------------------- lift: initial vector for level h from level h-1
static int cmd_lift(int h, const char *outdir, const char *vprev, const char *vout) {
    char path[4096]; size_t sz;
    snprintf(path, sizeof path, "%s/h%d_keys.bin", outdir, h);
    uint64_t *K = (uint64_t *)read_file(path, &sz); uint64_t N = sz / 8;
    snprintf(path, sizeof path, "%s/h%d_keys.bin", outdir, h - 1);
    uint64_t *Kp = (uint64_t *)read_file(path, &sz); uint64_t Np = sz / 8;
    double *vp = (double *)read_file(vprev, &sz);
    if (sz != Np * 8) { fprintf(stderr, "bad vprev\n"); return 1; }
    double vmin = 1e300; for (uint64_t i = 0; i < Np; i++) vmin = std::min(vmin, vp[i]);
    const int g = h - 1; const uint64_t Mg = (1ULL << g) - 1, Mh = (1ULL << h) - 1;
    std::vector<double> v(N); uint64_t found = 0;
#pragma omp parallel for schedule(static) reduction(+:found)
    for (uint64_t i = 0; i < N; i++) {
        uint64_t k = K[i];
        uint64_t x = (k >> (3 * h)) & Mh, y = (k >> (2 * h)) & Mh, dx = (k >> h) & Mh, dy = k & Mh;
        x &= Mg; y &= Mg; dx &= Mg; dy &= Mg;
        if ((x >> (g - 1)) & 1) { x ^= Mg; y ^= Mg; }
        uint64_t kp = (x << (3 * g)) | (y << (2 * g)) | (dx << g) | dy;
        const uint64_t *p = std::lower_bound(Kp, Kp + Np, kp);
        if (p != Kp + Np && *p == kp) { v[i] = vp[p - Kp]; found++; } else v[i] = vmin;
    }
    fprintf(stderr, "lift h=%d: %llu of %llu states project onto level-%d states\n", h, (unsigned long long)found, (unsigned long long)N, g);
    write_file(vout, v.data(), N * 8);
    return 0;
}

int main(int argc, char **argv) {
    if (argc < 4) { fprintf(stderr, "usage: see header\n"); return 1; }
    int h = atoi(argv[2]);
    if (h < 2 || h > MAXH) { fprintf(stderr, "h out of range\n"); return 1; }
    if (!strcmp(argv[1], "build")) return cmd_build(h, argv[3]);
    if (!strcmp(argv[1], "lift")) return cmd_lift(h, argv[3], argv[4], argv[5]);
    if (!strcmp(argv[1], "eigen")) return cmd_eigen(h, argv[3], atof(argv[4]), atoi(argv[5]), atof(argv[6]), argc > 7 ? argv[7] : nullptr);
    return 1;
}
