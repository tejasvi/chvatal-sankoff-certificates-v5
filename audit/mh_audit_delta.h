// Transition function of M_h for the audit checker (extracted verbatim from mhcheck.cpp).
#pragma once
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <algorithm>
typedef unsigned __int128 u128;
static int H;

// delta: returns false on REJECT; otherwise writes the reduced successor key.
static bool delta(uint64_t key, int c, int l, uint64_t *out) {
    const int h = H;
    const uint64_t m = (1ULL << h) - 1;
    uint64_t x = (key >> (3 * h)) & m, y = (key >> (2 * h)) & m, dx = (key >> h) & m, dy = key & m;
    int a[64], b[64];
    int W[40][40];                       // h <= 16 -> indices up to 2h
    for (int r = 1; r <= h; r++) a[r] = (int)((x >> (h - r)) & 1);
    for (int s = 1; s <= h; s++) b[s] = (int)((y >> (h - s)) & 1);
    W[h][h] = 64;                        // arbitrary offset, keeps values positive
    for (int r = h; r >= 1; r--) W[r - 1][h] = W[r][h] - (int)((dx >> (h - r)) & 1);
    for (int s = h; s >= 1; s--) W[h][s - 1] = W[h][s] - (int)((dy >> (h - s)) & 1);
    int aLen = h, bLen = h;
    if (l > 0) { for (int k = 0; k < l; k++) a[++aLen] = 1 - c; }
    else if (l < 0) { for (int k = 0; k < -l; k++) b[++bLen] = 1 - c; }
    a[++aLen] = c; b[++bLen] = c;
    for (int s = h + 1; s <= bLen; s++) W[0][s] = W[0][s - 1];
    for (int r = h + 1; r <= aLen; r++) W[r][0] = W[r - 1][0];
    for (int r = 1; r <= aLen; r++)
        for (int s = 1; s <= bLen; s++) {
            if (r <= h && s <= h) continue;
            int v;
            if (a[r] == b[s]) v = W[r - 1][s - 1] + 1;
            else v = std::max(W[r - 1][s], W[r][s - 1]);
            W[r][s] = v;
            int du = v - W[r - 1][s], dl = v - W[r][s - 1];
            if (du < 0 || du > 1 || dl < 0 || dl > 1) { fprintf(stderr, "increment outside {0,1}\n"); exit(3); }
        }
    int r = aLen, s = bLen, matches = 0;
    bool acc = false;
    while (r >= h && s >= h) {
        if (r == h && s == h) { acc = true; break; }
        if (W[r][s] == W[r - 1][s]) r--;
        else if (W[r][s] == W[r][s - 1]) s--;
        else {
            if (!(W[r][s] == W[r - 1][s - 1] + 1 && a[r] == b[s])) { fprintf(stderr, "inconsistent table\n"); exit(3); }
            r--; s--; matches++;
        }
    }
    if (!acc) return false;
    if (matches != 1) { fprintf(stderr, "accepted with %d matches\n", matches); exit(3); }
    uint64_t nx = 0, ny = 0, ndx = 0, ndy = 0;
    for (int i = aLen - h + 1; i <= aLen; i++) { nx = (nx << 1) | (uint64_t)a[i]; ndx = (ndx << 1) | (uint64_t)(W[i][bLen] - W[i - 1][bLen]); }
    for (int j = bLen - h + 1; j <= bLen; j++) { ny = (ny << 1) | (uint64_t)b[j]; ndy = (ndy << 1) | (uint64_t)(W[aLen][j] - W[aLen][j - 1]); }
    if ((nx >> (h - 1)) & 1) { nx ^= m; ny ^= m; }
    *out = (nx << (3 * h)) | (ny << (2 * h)) | (ndx << h) | ndy;
    return true;
}

