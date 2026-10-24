// mhstream_det.cpp: DETERMINISTIC, PORTABLE variant of mhstream.cpp for regenerating a certificate vector bit for bit.
//   mhstream_det H OUTDIR Z ITERS          (start vector: all ones; exactly ITERS power iterations; no early stop)
//   env MH_VINIT=FILE MH_START_IT=K       resume from the checkpoint written after iteration K (same result as no resume)
// Build with IEEE semantics and no FMA contraction, e.g.  g++ -O2 -fopenmp -mpopcnt -ffp-contract=off  (no -ffast-math);
// then every row sum is evaluated in a fixed order with separately rounded products and sums, the normalisation divides
// by an exact maximum, the weights are built by repeated multiplication, and the result does not depend on the thread
// count or the CPU.
// (Original mhstream.cpp header follows.)
// mhstream.cpp: memory-lean stored transition table for large h (h = 11, 12).
//   mhstream H OUTDIR ZLIST ITERS TOL [PREV_KEYS PREV_V]
// Needs OUTDIR/h<H>_keys.bin (sorted; from mhgroup bfs).  States are grouped by their string part g = key >> 2h = (x,y);
// the target group of an input (c,l) is a function of (x,y,c,l) alone, so a transition is stored as the RANK INSIDE
// the target group: uint16 if that group has < 2^16 states, else uint32 (two streams).  Per state a 2(2h-1)-bit
// accept mask (uint64).  The power iteration needs only: group starts, masks, the two streams, block offsets, v, vn.
// Transitions are computed by mh_fast.h (validated against mh_delta.h on all transitions for h <= 10).
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <csignal>
#include <ctime>
#include <vector>
#include <string>
#include <algorithm>
#include <omp.h>
#include "mh_fast.h"

static volatile sig_atomic_t g_stop = 0;
static void on_term(int) { g_stop = 1; }
static double now() { return omp_get_wtime(); }
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

// string part of the successor of group (x,y) under input t, after the complement reduction
static inline uint64_t target_group(int h, uint64_t g, int t) {
    const int L = 2 * h - 1; const uint64_t Mh = (1ULL << h) - 1;
    int c = t / L, l = t % L - (h - 1);
    uint64_t x = g >> h, y = g & Mh, cb = 1 - c, nx, ny;
    if (l >= 0) {   // top cbar^l c, bottom c
        uint64_t top = ((cb ? ((1ULL << l) - 1) : 0) << 1) | c;   // l+1 symbols, oldest first (MSB first)
        nx = ((x << (l + 1)) | top) & Mh; ny = ((y << 1) | c) & Mh;
    } else {
        int k = -l; uint64_t bot = ((cb ? ((1ULL << k) - 1) : 0) << 1) | c;
        nx = ((x << 1) | c) & Mh; ny = ((y << (k + 1)) | bot) & Mh;
    }
    if (nx >> (h - 1)) { nx ^= Mh; ny ^= Mh; }
    return (nx << h) | ny;
}

int main(int argc, char **argv) {
    if (argc < 6) { fprintf(stderr, "usage: mhstream H OUTDIR ZLIST ITERS TOL [PREV_KEYS PREV_V]\n"); return 1; }
    signal(SIGTERM, on_term); signal(SIGINT, on_term);
    fast_init();
    int h = atoi(argv[1]); std::string out = argv[2];
    std::vector<double> zs; { std::string s = argv[3]; size_t p = 0; while (p < s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); zs.push_back(atof(s.substr(p, q - p).c_str())); p = q + 1; } }
    int iters = atoi(argv[4]); double tol = atof(argv[5]);
    const int L = 2 * h - 1, NI = 2 * L, GB = 2 * h;
    double t0 = now(); size_t sz;
    uint64_t *keys = (uint64_t *)read_file((out + "/h" + std::to_string(h) + "_keys.bin").c_str(), &sz);
    const uint64_t N = sz / 8, NG = 1ULL << GB;
    std::vector<uint64_t> gs(NG + 1, 0);
    for (uint64_t i = 0; i < N; i++) gs[(keys[i] >> GB) + 1]++;
    for (uint64_t g = 0; g < NG; g++) gs[g + 1] += gs[g];
    std::vector<uint32_t> nonempty; for (uint64_t g = 0; g < NG; g++) if (gs[g + 1] > gs[g]) nonempty.push_back((uint32_t)g);
    fprintf(stderr, "h=%d N=%llu groups=%zu (%.0fs)\n", h, (unsigned long long)N, nonempty.size(), now() - t0);
    // ---- pass A: masks and per-group stream counts
    std::vector<uint64_t> mask(N);
    std::vector<uint64_t> c16(nonempty.size() + 1, 0), c32(nonempty.size() + 1, 0);
#pragma omp parallel for schedule(dynamic, 16)
    for (size_t gi = 0; gi < nonempty.size(); gi++) {
        uint64_t g = nonempty[gi]; uint64_t o[64]; uint64_t n16 = 0, n32 = 0;
        uint64_t tg[64]; bool big[64];
        for (int t = 0; t < NI; t++) { tg[t] = target_group(h, g, t); big[t] = (gs[tg[t] + 1] - gs[tg[t]]) >= 65536; }
        for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
            fast_delta_all(h, keys[i], o); uint64_t m = 0;
            for (int t = 0; t < NI; t++) if (o[t] != ~0ULL) {
                m |= 1ULL << t;
                if ((o[t] >> GB) != tg[t]) { fprintf(stderr, "target group mismatch\n"); exit(1); }
                if (big[t]) n32++; else n16++;
            }
            mask[i] = m;
        }
        c16[gi + 1] = n16; c32[gi + 1] = n32;
    }
    for (size_t gi = 0; gi < nonempty.size(); gi++) { c16[gi + 1] += c16[gi]; c32[gi + 1] += c32[gi]; }
    const uint64_t E16 = c16[nonempty.size()], E32 = c32[nonempty.size()];
    fprintf(stderr, "edges: %llu in uint16, %llu in uint32 (%.1f GB) (%.0fs)\n", (unsigned long long)E16, (unsigned long long)E32,
            (E16 * 2.0 + E32 * 4.0) * 1e-9, now() - t0);
    uint16_t *s16 = (uint16_t *)malloc(E16 * 2 + 8); uint32_t *s32 = (uint32_t *)malloc(E32 * 4 + 8);
    if (!s16 || !s32) { fprintf(stderr, "malloc streams\n"); return 1; }
    uint64_t missing = 0;
    // ---- pass B: fill the streams (in-group ranks by binary search in the target group's key range)
#pragma omp parallel for schedule(dynamic, 16) reduction(+:missing)
    for (size_t gi = 0; gi < nonempty.size(); gi++) {
        uint64_t g = nonempty[gi]; uint64_t o[64]; uint64_t p16 = c16[gi], p32 = c32[gi];
        uint64_t tg[64]; bool big[64];
        for (int t = 0; t < NI; t++) { tg[t] = target_group(h, g, t); big[t] = (gs[tg[t] + 1] - gs[tg[t]]) >= 65536; }
        for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
            fast_delta_all(h, keys[i], o);
            for (int t = 0; t < NI; t++) if (o[t] != ~0ULL) {
                const uint64_t *b = keys + gs[tg[t]], *e = keys + gs[tg[t] + 1];
                const uint64_t *p = std::lower_bound(b, e, o[t]);
                if (p == e || *p != o[t]) { missing++; continue; }
                uint64_t r = p - b;
                if (big[t]) s32[p32++] = (uint32_t)r; else s16[p16++] = (uint16_t)r;
            }
        }
    }
    if (missing) { fprintf(stderr, "closure failure %llu\n", (unsigned long long)missing); return 1; }
    fprintf(stderr, "table built (%.0fs)\n", now() - t0);
    // ---- initial vector (optionally lifted from level h-1), needs keys
    std::vector<double> v(N, 1.0), vn(N);
    if (argc >= 8) {
        if (getenv("MH_WAIT_FILE")) {   // wait until the lift files are complete (marker written after the copy)
            while (true) { FILE *wf = fopen(getenv("MH_WAIT_FILE"), "r"); if (wf) { fclose(wf); break; } if (g_stop) return 3; struct timespec ts = {10, 0}; nanosleep(&ts, 0); }
            fprintf(stderr, "lift files ready (%.0fs)\n", now() - t0);
        }
        size_t sk, sv; uint64_t *Kp = (uint64_t *)read_file(argv[6], &sk); double *Vp = (double *)read_file(argv[7], &sv);
        uint64_t Np = sk / 8; if (sv != Np * 8) { fprintf(stderr, "bad prev\n"); return 1; }
        double vmin = 1e300; for (uint64_t i = 0; i < Np; i++) vmin = std::min(vmin, Vp[i]);
        const int g = h - 1; const uint64_t Mg = (1ULL << g) - 1; uint64_t found = 0;
#pragma omp parallel for schedule(static) reduction(+:found)
        for (uint64_t i = 0; i < N; i++) {
            uint64_t k = keys[i];
            uint64_t x = (k >> (3 * h)) & Mg, y = (k >> (2 * h)) & Mg, dx = (k >> h) & Mg, dy = k & Mg;
            if ((x >> (g - 1)) & 1) { x ^= Mg; y ^= Mg; }
            uint64_t kp = (x << (3 * g)) | (y << (2 * g)) | (dx << g) | dy;
            const uint64_t *p = std::lower_bound(Kp, Kp + Np, kp);
            if (p != Kp + Np && *p == kp) { v[i] = Vp[p - Kp]; found++; } else v[i] = vmin;
        }
        free(Kp); free(Vp);
        fprintf(stderr, "lifted initial vector: %llu of %llu found at level %d\n", (unsigned long long)found, (unsigned long long)N, g);
    }
    if (getenv("MH_VINIT")) {   // resume: initial vector read directly (same state order)
        size_t sv; double *p = (double *)read_file(getenv("MH_VINIT"), &sv);
        if (sv != N * 8) { fprintf(stderr, "bad MH_VINIT size\n"); return 1; }
        memcpy(v.data(), p, N * 8); free(p);
        fprintf(stderr, "initial vector read from %s (%.0fs)\n", getenv("MH_VINIT"), now() - t0);
    }
    free(keys);
    // ---- power iteration
    for (double z : zs) {
        double w[64], zp[64]; zp[0] = 1.0;
        for (int k = 1; k <= h + 1; k++) zp[k] = zp[k - 1] * z;           // IEEE products in a fixed order (no libm pow)
        for (int t = 0; t < NI; t++) { int l = (t % L) - (h - 1), al = abs(l); w[t] = (al < h - 1) ? zp[al + 2] : zp[h + 1] / (1.0 - z); }
        char zb[64]; snprintf(zb, sizeof zb, "%.6f", z);
        std::string vpath = out + "/h" + std::to_string(h) + "_vdet_" + zb + ".bin";
        double rmin = 0, rmax = 0, te = now();
        int it0 = getenv("MH_START_IT") ? atoi(getenv("MH_START_IT")) : 0;
        for (int it = it0 + 1; it <= iters; it++) {
            double mx = 0; rmin = 1e300; rmax = 0;
#pragma omp parallel for schedule(dynamic, 16) reduction(max:mx, rmax) reduction(min:rmin)
            for (size_t gi = 0; gi < nonempty.size(); gi++) {
                uint64_t g = nonempty[gi]; uint64_t p16 = c16[gi], p32 = c32[gi];
                uint64_t base[64]; bool big[64];
                for (int t = 0; t < NI; t++) { uint64_t tg = target_group(h, g, t); base[t] = gs[tg]; big[t] = (gs[tg + 1] - gs[tg]) >= 65536; }
                for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
                    uint64_t m = mask[i]; double s = 0;
                    while (m) {
                        int t = __builtin_ctzll(m); m &= m - 1;
                        uint64_t r = big[t] ? s32[p32++] : s16[p16++];
                        s += w[t] * v[base[t] + r];
                    }
                    vn[i] = s; double rr = s / v[i];
                    if (s > mx) mx = s; if (rr > rmax) rmax = rr; if (rr < rmin) rmin = rr;
                }
            }
            double inv = 1.0 / mx;
#pragma omp parallel for schedule(static)
            for (uint64_t i = 0; i < N; i++) v[i] = vn[i] * inv;
            bool done = rmax / rmin < 1 + tol || it == iters;
            if (it % 10 == 0 || done || g_stop || it <= 2)
                fprintf(stderr, "  z=%s it %d: ratio in [%.15f, %.15f] gap %.3e (%.0fs)\n", zb, it, rmin, rmax, rmax / rmin - 1, now() - te);
            if (it % 25 == 0 || done || g_stop) {
                write_file(vpath, v.data(), N * 8);
                FILE *fi = fopen((vpath + ".it").c_str(), "w"); if (fi) { fprintf(fi, "%d\n", it); fclose(fi); }
            }
            if (done) break;
            if (g_stop) { fprintf(stderr, "stopped; vector checkpointed\n"); return 3; }
        }
        printf("h=%d z=%s N=%llu lambda in [%.15f, %.15f] bound(rmax)=%.9f (%.0fs total)\n", h, zb, (unsigned long long)N, rmin, rmax,
               2 * log(2 * z) / log(rmax), now() - t0);
        fflush(stdout);
    }
    return 0;
}
