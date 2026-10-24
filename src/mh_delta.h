#pragma once
#include <cstdint>
static const uint64_t REJECT = ~0ULL;
static const int MAXH = 15;
// ---------------------------------------------------------------- transition: direct DP on the window
static inline uint64_t delta_dp(int h, uint64_t key, int c, int l) {
    const uint64_t M = (1ULL << h) - 1;
    unsigned x = (key >> (3 * h)) & M, y = (key >> (2 * h)) & M, dx = (key >> h) & M, dy = key & M;
    int a[2 * MAXH + 2], b[2 * MAXH + 2];
    int W[2 * MAXH + 2][2 * MAXH + 2];
    for (int r = 1; r <= h; r++) a[r] = (x >> (h - r)) & 1;
    for (int s = 1; s <= h; s++) b[s] = (y >> (h - s)) & 1;
    int aL = h, bL = h;
    if (l >= 0) { for (int t = 0; t < l; t++) a[++aL] = 1 - c; a[++aL] = c; b[++bL] = c; }
    else        { a[++aL] = c; for (int t = 0; t < -l; t++) b[++bL] = 1 - c; b[++bL] = c; }
    W[h][h] = 64;
    for (int r = h; r >= 1; r--) W[r - 1][h] = W[r][h] - ((dx >> (h - r)) & 1);
    for (int s = h; s >= 1; s--) W[h][s - 1] = W[h][s] - ((dy >> (h - s)) & 1);
    for (int s = h + 1; s <= bL; s++) W[0][s] = W[0][h];
    for (int r = h + 1; r <= aL; r++) W[r][0] = W[h][0];
    for (int r = 1; r <= aL; r++) {
        int s0 = (r > h) ? 1 : h + 1;
        for (int s = s0; s <= bL; s++) {
            if (a[r] == b[s]) W[r][s] = W[r - 1][s - 1] + 1;
            else W[r][s] = W[r - 1][s] > W[r][s - 1] ? W[r - 1][s] : W[r][s - 1];
        }
    }
    int r = aL, s = bL; bool ok = false;
    while (r >= h && s >= h) {
        if (W[r - 1][s] == W[r][s]) r--;
        else if (W[r][s - 1] == W[r][s]) s--;
        else { r--; s--; }
        if (r == h && s == h) { ok = true; break; }
    }
    if (!ok) return REJECT;
    uint64_t nx = 0, ny = 0, ndx = 0, ndy = 0;
    for (int i = aL - h + 1; i <= aL; i++) { nx = (nx << 1) | a[i]; ndx = (ndx << 1) | (uint64_t)(W[i][bL] - W[i - 1][bL]); }
    for (int j = bL - h + 1; j <= bL; j++) { ny = (ny << 1) | b[j]; ndy = (ndy << 1) | (uint64_t)(W[aL][j] - W[aL][j - 1]); }
    if ((nx >> (h - 1)) & 1) { nx ^= M; ny ^= M; }
    return (nx << (3 * h)) | (ny << (2 * h)) | (ndx << h) | ndy;
}

static inline uint64_t start_key(int h) {
    const uint64_t M = (1ULL << h) - 1;
    return (0ULL << (3 * h)) | (0ULL << (2 * h)) | (M << h) | M;
}

