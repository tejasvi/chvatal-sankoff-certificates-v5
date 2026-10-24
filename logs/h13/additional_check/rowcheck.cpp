// rowcheck.cpp: independent evaluation of single rows of an M_h certificate with binary32 v (audit of the h=13 certificate).
// Transition: the step() function of the audited check.cpp (sha256 3704d6e5), copied verbatim. Lookup: binary search in the
// mmapped key file. Evaluation (own code): v = m 2^e decoded from the binary32 bit pattern; S_q = sum ceil(Wt[|l|] m' 2^(e'-e));
// row value = ceil(S_q / m_q), all in unsigned __int128. Prints, per requested row, the row value and the number of accepted
// inputs; with --random R SEED also R pseudo-random rows.
//   rowcheck H KEYS VEC_F32 WEIGHTS ROW [ROW ...] [--random R SEED]
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <algorithm>
#include <vector>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
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
    // strings: bit (h-1) of x is a[1]
    for (int i = 1; i <= h; i++) { w.a[i] = (x >> (h - i)) & 1; w.b[i] = (y >> (h - i)) & 1; }
    w.aL = h; w.bL = h;
    // top string of T_{c,l}: cbar^l c (l>=0) or c (l<0); bottom: c (l>=0) or cbar^|l| c (l<0)
    int top = (l >= 0) ? l + 1 : 1, bot = (l >= 0) ? 1 : -l + 1;
    for (int i = 1; i <= top; i++) w.a[h + i] = (i == top) ? c : 1 - c;
    for (int j = 1; j <= bot; j++) w.b[h + j] = (j == bot) ? c : 1 - c;
    w.aL = h + top; w.bL = h + bot;
    for (int i = 0; i <= w.aL; i++) for (int j = 0; j <= w.bL; j++) w.known[i][j] = false;   // only this region is ever read
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


static const void *mapf(const char *p, size_t *sz) {
    int fd = open(p, O_RDONLY); if (fd < 0) { perror(p); exit(1); }
    struct stat st; fstat(fd, &st); *sz = (size_t)st.st_size;
    void *m = mmap(nullptr, *sz, PROT_READ, MAP_SHARED, fd, 0); if (m == MAP_FAILED) { perror("mmap"); exit(1); }
    close(fd); return m;
}
static void dec(uint32_t u, uint64_t &m, int &e) {         // binary32 -> m 2^e, 2^52 <= m < 2^53 (own code)
    uint32_t E = (u >> 23) & 0xff, F = u & 0x7fffff;
    if (u >> 31 || E == 0xff || (E == 0 && F == 0)) { fprintf(stderr, "bad v entry %08x\n", u); exit(2); }
    if (E) { m = ((uint64_t)(F | 0x800000u)) << 29; e = (int)E - 150 - 29; }
    else { int p = 0; while ((F >> (p + 1)) != 0) p++; m = ((uint64_t)F) << (52 - p); e = -149 - (52 - p); }
}
int main(int argc, char **argv) {
    if (argc < 6) { fprintf(stderr, "usage\n"); return 1; }
    h = atoi(argv[1]); MK = (1ULL << h) - 1;
    size_t nk, nv; const uint64_t *K = (const uint64_t *)mapf(argv[2], &nk); const uint32_t *V = (const uint32_t *)mapf(argv[3], &nv);
    uint64_t N = nk / 8; if (nv != 4 * N) { fprintf(stderr, "size mismatch\n"); return 1; }
    uint64_t Wt[20]; FILE *fw = fopen(argv[4], "r"); for (int k = 0; k < h; k++) if (fscanf(fw, "%lu", &Wt[k]) != 1) return 1; fclose(fw);
    std::vector<uint64_t> rows;
    for (int i = 5; i < argc; i++) {
        if (!strcmp(argv[i], "--random")) { uint64_t R = strtoull(argv[i + 1], 0, 10), s = strtoull(argv[i + 2], 0, 10);
            for (uint64_t r = 0; r < R; r++) { s = s * 6364136223846793005ULL + 1442695040888963407ULL; rows.push_back((s >> 11) % N); } i += 2; }
        else rows.push_back(strtoull(argv[i], 0, 10));
    }
    for (uint64_t i : rows) {
        uint64_t q = K[i], mi; int ei; dec(V[i], mi, ei);
        u128 S = 0; int nacc = 0; bool huge = false;
        for (int c = 0; c <= 1; c++) for (int l = -(h - 1); l <= h - 1; l++) {
            uint64_t t;
            if (!step(q, c, l, &t)) continue;
            nacc++;
            const uint64_t *p = std::lower_bound(K, K + N, t);
            if (p == K + N || *p != t) { printf("row %lu: successor %lx not listed\n", i, t); return 2; }
            uint64_t mj; int ej; dec(V[p - K], mj, ej);
            u128 X = (u128)Wt[l < 0 ? -l : l] * mj; int sh = ej - ei; u128 T;
            if (sh >= 0) { if (sh >= 118 || X >= ((((u128)1) << 118) >> sh)) { huge = true; continue; } T = X << sh; }
            else if (-sh >= 127) T = 1;
            else { T = X >> (-sh); if (X & ((((u128)1) << (-sh)) - 1)) T += 1; }
            S += T;
        }
        uint64_t val;
        if (huge) val = ~0ULL; else { u128 Q = S / mi; if (S % mi) Q++; val = (Q >> 64) ? ~0ULL : (uint64_t)Q; }
        printf("row %lu key %lx accepted %d value %lu\n", i, q, nacc, val);
    }
    return 0;
}
