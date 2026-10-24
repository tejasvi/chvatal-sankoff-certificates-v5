// check.cpp: independent exact checker for a Collatz-Wielandt certificate of Lueker's automaton M_h.
// Written separately from mh.cpp; it shares only the definition in Section 3 of the paper.
//
//   check H KEYS VEC WEIGHTS [THREADS]
//     KEYS    : sorted distinct uint64 state codes (x<<3h | y<<2h | dx<<h | dy, oldest bit = MSB)
//     VEC     : one IEEE double per state, all positive and normal (the vector v)
//     WEIGHTS : text file with h integers Wt[0..h-1], Wt[k] >= 2^64 * w_z(k) (k = |l|), from cert_weights.py
//
// Checks: (1) keys strictly increasing; (2) start state present; (3) every accepted successor of every listed
// state is listed (closure); (4) exact integer evaluation of
//     S_q = sum_{c,l accepted} Wt[|l|] * v(delta(q,T_{c,l}))   against   v(q),
// giving lam_num = max_q ceil(2^64 S_q / (2^64 v(q))) in exact arithmetic (sum rounded up only), so that
//     A_z v <= (lam_num / 2^64) v   holds exactly.
// Prints lam_num (decimal integer).  Everything is integer arithmetic (unsigned __int128), no FP rounding modes.
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <vector>
#include <algorithm>
#include <omp.h>

typedef unsigned __int128 u128;
static int h;
static uint64_t MK;

struct Win {               // window table with explicit "known" flags
    int a[40], b[40];      // a[1..aL], b[1..bL]
    int T[40][40];
    bool known[40][40];
    int aL, bL;
};

// Build the window of state q after appending T_{c,l}; return false if the canonical backtrack rejects.
static bool step(uint64_t q, int c, int l, uint64_t *out) {
    Win w;
    unsigned dy = q & MK, dx = (q >> h) & MK, y = (q >> (2 * h)) & MK, x = (q >> (3 * h)) & MK;
    for (int i = 0; i < 40; i++) for (int j = 0; j < 40; j++) w.known[i][j] = false;
    // strings: bit (h-1) of x is a[1]
    for (int i = 1; i <= h; i++) { w.a[i] = (x >> (h - i)) & 1; w.b[i] = (y >> (h - i)) & 1; }
    w.aL = h; w.bL = h;
    // top string of T_{c,l}: cbar^l c (l>=0) or c (l<0); bottom: c (l>=0) or cbar^|l| c (l<0)
    int top = (l >= 0) ? l + 1 : 1, bot = (l >= 0) ? 1 : -l + 1;
    for (int i = 1; i <= top; i++) w.a[h + i] = (i == top) ? c : 1 - c;
    for (int j = 1; j <= bot; j++) w.b[h + j] = (j == bot) ? c : 1 - c;
    w.aL = h + top; w.bL = h + bot;
    // last column (column h) rows 0..h and last row (row h) columns 0..h; anchor T[h][h] = 100
    w.T[h][h] = 100; w.known[h][h] = true;
    for (int i = h; i >= 1; i--) { int inc = (dx >> (h - i)) & 1; w.T[i - 1][h] = w.T[i][h] - inc; w.known[i - 1][h] = true; }
    for (int j = h; j >= 1; j--) { int inc = (dy >> (h - j)) & 1; w.T[h][j - 1] = w.T[h][j] - inc; w.known[h][j - 1] = true; }
    // constant extension of row 0 to the right and of column 0 downwards
    for (int j = h + 1; j <= w.bL; j++) { w.T[0][j] = w.T[0][h]; w.known[0][j] = true; }
    for (int i = h + 1; i <= w.aL; i++) { w.T[i][0] = w.T[h][0]; w.known[i][0] = true; }
    // fill all cells with i > h or j > h (both >= 1) by the LCS recurrence
    for (int i = 1; i <= w.aL; i++)
        for (int j = 1; j <= w.bL; j++) {
            if (i <= h && j <= h) continue;
            if (!w.known[i - 1][j - 1] || !w.known[i - 1][j] || !w.known[i][j - 1]) { fprintf(stderr, "internal: unknown neighbour\n"); exit(3); }
            int v;
            if (w.a[i] == w.b[j]) v = w.T[i - 1][j - 1] + 1;
            else v = std::max(w.T[i - 1][j], w.T[i][j - 1]);
            w.T[i][j] = v; w.known[i][j] = true;
            int d1 = v - w.T[i - 1][j], d2 = v - w.T[i][j - 1];
            if (d1 < 0 || d1 > 1 || d2 < 0 || d2 > 1) { fprintf(stderr, "internal: increment not 0/1\n"); exit(3); }
        }
    // canonical backtrack (up, else left, else diagonal) inside rows >= h, columns >= h
    int i = w.aL, j = w.bL, diag = 0;
    for (;;) {
        if (i < h || j < h) return false;
        if (i == h && j == h) break;
        if (!w.known[i - 1][j] || !w.known[i][j - 1]) { fprintf(stderr, "internal: backtrack unknown\n"); exit(3); }
        if (w.T[i - 1][j] == w.T[i][j]) i--;
        else if (w.T[i][j - 1] == w.T[i][j]) j--;
        else { i--; j--; diag++; }
    }
    if (diag != 1) { fprintf(stderr, "internal: %d diagonal steps\n", diag); exit(3); }
    uint64_t nx = 0, ny = 0, ndx = 0, ndy = 0;
    for (int r = w.aL - h + 1; r <= w.aL; r++) { nx = 2 * nx + w.a[r]; ndx = 2 * ndx + (uint64_t)(w.T[r][w.bL] - w.T[r - 1][w.bL]); }
    for (int s = w.bL - h + 1; s <= w.bL; s++) { ny = 2 * ny + w.b[s]; ndy = 2 * ndy + (uint64_t)(w.T[w.aL][s] - w.T[w.aL][s - 1]); }
    if (nx >> (h - 1)) { nx = MK & ~nx; ny = MK & ~ny; }   // complement symmetry: first bit of x is 0
    *out = (nx << (3 * h)) | (ny << (2 * h)) | (ndx << h) | ndy;
    return true;
}

static void *slurp(const char *path, size_t *n) {
    FILE *f = fopen(path, "rb"); if (!f) { perror(path); exit(1); }
    fseek(f, 0, SEEK_END); size_t sz = ftell(f); fseek(f, 0, SEEK_SET);
    char *p = (char *)malloc(sz + 8); size_t d = 0;
    while (d < sz) { size_t r = fread(p + d, 1, std::min(sz - d, (size_t)1 << 30), f); if (!r) { perror("read"); exit(1); } d += r; }
    fclose(f); *n = sz; return p;
}

int main(int argc, char **argv) {
    if (argc < 5) { fprintf(stderr, "usage: check H KEYS VEC WEIGHTS\n"); return 1; }
    h = atoi(argv[1]); MK = (1ULL << h) - 1;
    if (h < 2 || h > 15) { fprintf(stderr, "bad h\n"); return 1; }
    size_t nk, nv;
    uint64_t *K = (uint64_t *)slurp(argv[2], &nk); uint64_t N = nk / 8;
    double *V = (double *)slurp(argv[3], &nv);
    if (nk % 8 || nv != N * 8) { fprintf(stderr, "size mismatch: %zu keys bytes, %zu vec bytes\n", nk, nv); return 1; }
    uint64_t Wt[16]; FILE *fw = fopen(argv[4], "r"); if (!fw) { perror(argv[4]); return 1; }
    for (int k = 0; k < h; k++) { unsigned long long t; if (fscanf(fw, "%llu", &t) != 1) { fprintf(stderr, "weights file short\n"); return 1; } Wt[k] = t; }
    fclose(fw);
    // (1) strictly increasing keys, all within 4h bits
    for (uint64_t i = 0; i < N; i++) {
        if (K[i] >> (4 * h)) { fprintf(stderr, "FAIL key out of range at %llu\n", (unsigned long long)i); return 2; }
        if (i && K[i] <= K[i - 1]) { fprintf(stderr, "FAIL keys not strictly increasing at %llu\n", (unsigned long long)i); return 2; }
    }
    // (2) start state <0^h,0^h,1^h,1^h>
    uint64_t q0 = (MK << h) | MK;
    if (!std::binary_search(K, K + N, q0)) { fprintf(stderr, "FAIL start state missing\n"); return 2; }
    // positivity / normality of v, and decomposition v = m * 2^e with m < 2^53 an integer
    std::vector<uint64_t> m(N); std::vector<int> e(N);
    for (uint64_t i = 0; i < N; i++) {
        double t = V[i];
        if (!(t > 0) || !std::isnormal(t)) { fprintf(stderr, "FAIL v[%llu] not positive normal\n", (unsigned long long)i); return 2; }
        int ex; double f = frexp(t, &ex);           // t = f 2^ex, f in [1/2,1)
        double mm = ldexp(f, 53);                   // exact integer in [2^52, 2^53)
        m[i] = (uint64_t)mm; e[i] = ex - 53;
        if ((double)m[i] != mm || ldexp((double)m[i], e[i]) != t) { fprintf(stderr, "FAIL decomposition\n"); return 2; }
    }
    // radix index on the top bits for the successor lookups
    int B = std::min(4 * h, 24), SH = 4 * h - B;
    std::vector<uint64_t> start((1ULL << B) + 1, 0);
    {
        uint64_t p = 0;
        for (uint64_t bkt = 0; bkt <= (1ULL << B); bkt++) {
            while (p < N && (K[p] >> SH) < bkt) p++;
            start[bkt] = p;
        }
    }
    uint64_t lam_num = 0, nacc = 0, nfail = 0;
    double t0 = omp_get_wtime();
#pragma omp parallel for schedule(dynamic, 4096) reduction(max:lam_num) reduction(+:nacc, nfail)
    for (uint64_t i = 0; i < N; i++) {
        u128 S = 0; bool huge = false;
        for (int c = 0; c <= 1; c++)
            for (int l = -(h - 1); l <= h - 1; l++) {
                uint64_t t;
                if (!step(K[i], c, l, &t)) continue;
                nacc++;
                uint64_t bk = t >> SH;
                const uint64_t *lo = K + start[bk], *hi = K + start[bk + 1];
                const uint64_t *p = std::lower_bound(lo, hi, t);
                if (p == hi || *p != t) {
#pragma omp critical
                    fprintf(stderr, "FAIL closure: successor %llx of state %llx (c=%d l=%d) not listed\n",
                            (unsigned long long)t, (unsigned long long)K[i], c, l);
                    nfail++; continue;
                }
                uint64_t j = p - K;
                u128 X = (u128)Wt[l < 0 ? -l : l] * m[j];           // < 2^117
                int sh = e[j] - e[i];
                u128 T;
                const u128 LIM = ((u128)1) << 118;                  // any term >= 2^118 exceeds 2^64 * m_q (< 2^117)
                if (sh >= 0) {
                    if (sh >= 118 || X >= (LIM >> sh)) { huge = true; continue; }   // ratio >= 1: row fails
                    T = X << sh;
                } else if (-sh >= 127) T = 1;                        // rounds up to one unit
                else T = (X >> (-sh)) + (((X & ((((u128)1) << (-sh)) - 1)) != 0) ? 1 : 0);   // ceil
                S += T;
            }
        uint64_t Lq;
        if (huge) Lq = ~0ULL;
        else {
            u128 Q = S / m[i]; if (S % m[i]) Q += 1;               // ceil(S / m_q)
            Lq = (Q >> 64) ? ~0ULL : (uint64_t)Q;
        }
        if (Lq > lam_num) lam_num = Lq;
    }
    if (nfail) { printf("FAIL: %llu closure failures\n", (unsigned long long)nfail); return 2; }
    printf("h=%d states=%llu accepted_transitions=%llu lam_num=%llu lam_cert=%.17g time=%.1fs\n", h,
           (unsigned long long)N, (unsigned long long)nacc, (unsigned long long)lam_num, ldexp((double)lam_num, -64),
           omp_get_wtime() - t0);
    printf("CLAIM: A_z v <= (%llu / 2^64) v exactly, on a transition-closed state set containing the start state\n",
           (unsigned long long)lam_num);
    return 0;
}
