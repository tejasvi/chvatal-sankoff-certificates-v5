// mh_fast.h: bit-parallel transitions of M_h (same automaton as mh_delta.h; validated against it exhaustively).
// Internal bit order: row i (resp. column s) of the window at bit i-1, i.e. OLDEST at bit 0, so that additions carry
// from the oldest row/column to the newest, as in the bit-vector LCS recurrence (Crochemore et al. 2001):
//   with V = complement of the increment vector of a column (top boundary row constant) and M = match mask of the new
//   column's symbol against the rows,  V' = (V + (V & M)) | (V & ~M).
// Keys are stored with the oldest entry in the MOST significant bit, so the four fields are bit-reversed on entry/exit.
#pragma once
#include <cstdint>

static uint16_t g_rev16[65536];
static inline void fast_init() {
    for (uint32_t v = 0; v < 65536; v++) { uint32_t r = 0; for (int b = 0; b < 16; b++) if (v >> b & 1) r |= 1u << (15 - b); g_rev16[v] = (uint16_t)r; }
}
static inline uint32_t revh(uint32_t v, int h) { return (uint32_t)g_rev16[v] >> (16 - h); }   // reverse the low h bits

// one bit-vector LCS step over n positions (mask Mn = 2^n - 1): inc = increment vector (1 = +1), m = match mask
static inline uint32_t lcs_step(uint32_t inc, uint32_t m, uint32_t Mn) {
    uint32_t V = ~inc & Mn;
    uint32_t Vn = ((V + (V & m)) | (V & ~m)) & Mn;
    return ~Vn & Mn;
}

// All 2(2h-1) transitions of state key: out[c*(2h-1) + l+h-1] = successor key or ~0 (reject).
static inline void fast_delta_all(int h, uint64_t key, uint64_t *out) {
    const uint32_t Mh = (1u << h) - 1;
    const int L = 2 * h - 1;
    uint32_t x = (key >> (3 * h)) & Mh, y = (key >> (2 * h)) & Mh, dx = (key >> h) & Mh, dy = key & Mh;
    uint32_t xr = revh(x, h), yr = revh(y, h), dxr = revh(dx, h), dyr = revh(dy, h);   // oldest at bit 0
    const int pdx = __builtin_popcount(dxr), pdy = __builtin_popcount(dyr);
    for (int c = 0; c < 2; c++) {
        const int cb = 1 - c;
        // match masks of a symbol against the h old columns (y) and the h old rows (x)
        const uint32_t mcolsY_c = c ? yr : (~yr & Mh), mcolsY_cb = cb ? yr : (~yr & Mh);
        const uint32_t mrowsX_c = c ? xr : (~xr & Mh), mrowsX_cb = cb ? xr : (~xr & Mh);
        // ---------------- l >= 0: rows h+1 .. h+l (symbol cb), row h+l+1 (symbol c); then one column (symbol c)
        {
            uint32_t H = dyr;            // horizontal increments of the current last row over columns 1..h
            uint32_t incH = 0;           // vertical increments of column h at rows h+1.. (bit r-1)
            int pprev = pdy;
            for (int l = 0; l <= h - 1; l++) {
                // rows h+1..h+l are cb (already processed in H/incH); now add row r = h+l+1 with symbol c
                const int r = h + l + 1, aL = r;
                uint32_t Hc = lcs_step(H, mcolsY_c, Mh);
                int pc_ = __builtin_popcount(Hc);
                uint32_t inc_last = (uint32_t)(pc_ - pprev);            // increment of column h at row aL
                uint32_t incCol = dxr | (incH) | (inc_last << (aL - 1));  // column h increments, rows 1..aL
                uint64_t res = ~0ULL;
                // acceptance (i): column h flat on rows h+1..aL
                if ((incH | (inc_last << (aL - 1))) == 0) {
                    // column h+1 with symbol c over rows 1..aL
                    const uint32_t Ma = (aL >= 32) ? 0xffffffffu : ((1u << aL) - 1);
                    // rows: 1..h old (x), h+1..h+l cb, aL c
                    uint32_t mrows = mrowsX_c | (1u << (aL - 1));         // rows h+1..h+l are cb: no match with c
                    uint32_t incN = lcs_step(incCol, mrows, Ma);
                    // acceptance (ii): W(aL-1,h+1) - W(aL-1,h) = 0
                    const uint32_t Mb = (1u << (aL - 1)) - 1;
                    if (__builtin_popcount(incN & Mb) == __builtin_popcount(incCol & Mb)) {
                        // new state
                        uint32_t nxr;   // new x, oldest at bit 0: a[aL-h+1 .. aL]
                        // full a as bits: rows 1..h = xr, rows h+1..h+l = cb, row aL = c (bit aL-1)
                        uint64_t afull = (uint64_t)xr | ((uint64_t)(cb ? ((1u << l) - 1) : 0) << h) | ((uint64_t)c << (aL - 1));
                        nxr = (uint32_t)(afull >> (aL - h)) & Mh;
                        uint32_t nyr = (yr >> 1) | ((uint32_t)c << (h - 1));            // b[2..h+1]
                        uint32_t ndxr = (incN >> (aL - h)) & Mh;                            // rows aL-h+1..aL of column h+1
                        uint32_t lastH = (uint32_t)(__builtin_popcount(incN) - __builtin_popcount(incCol));   // W(aL,h+1)-W(aL,h)
                        uint32_t ndyr = (Hc >> 1) | (lastH << (h - 1));                     // columns 2..h+1 of row aL
                        uint32_t nx = revh(nxr, h), ny = revh(nyr, h), ndx = revh(ndxr, h), ndy = revh(ndyr, h);
                        if (nx >> (h - 1)) { nx ^= Mh; ny ^= Mh; }
                        res = ((uint64_t)nx << (3 * h)) | ((uint64_t)ny << (2 * h)) | ((uint64_t)ndx << h) | ndy;
                    }
                }
                out[c * L + l + h - 1] = res;
                // extend by one more cb row (row h+l+1 becomes cb) for the next l
                uint32_t Hb = lcs_step(H, mcolsY_cb, Mh);
                int pb = __builtin_popcount(Hb);
                incH |= (uint32_t)(pb - pprev) << (r - 1);
                H = Hb; pprev = pb;
            }
        }
        // ---------------- l < 0: row h+1 (symbol c); columns h+1..h+|l| (symbol cb), column h+|l|+1 (symbol c)
        {
            uint32_t H1 = lcs_step(dyr, mcolsY_c, Mh);                 // row h+1 horizontal increments, columns 1..h
            uint32_t inc1 = (uint32_t)(__builtin_popcount(H1) - pdy);  // column h increment at row h+1
            const int aL = h + 1;
            const uint32_t Ma = (1u << aL) - 1, Mrh = Mh;               // rows 1..h+1 ; rows 1..h
            uint32_t col = dxr | (inc1 << h);                           // column h increments over rows 1..h+1
            const uint32_t mrows_c = mrowsX_c | (1u << h), mrows_cb = mrowsX_cb;   // row h+1 holds symbol c
            // running quantities over the cb columns
            bool flat = true, rowh_inc = true;   // (i) row h flat so far; (ii) increments at row h are 1 so far
            int pcol = __builtin_popcount(col);  // W(h+1, s) - W(0, s) for the current column s
            uint32_t hrow_new = 0;               // horizontal increments of row h+1 over the new columns (bit t-1 for column h+t)
            for (int k = 1; k <= h - 1; k++) {   // l = -k: k cb columns then one c column
                // add the k-th cb column (column h+k)
                uint32_t cn = lcs_step(col, mrows_cb, Ma);
                // (i): W(h,h+k) - W(h,h+k-1) = popcount over rows 1..h difference
                if (__builtin_popcount(cn & Mrh) != __builtin_popcount(col & Mrh)) flat = false;
                // (ii) for columns h+1..bLen-1: increment at row h (bit h-1) must be 1
                if (!((cn >> (h - 1)) & 1)) rowh_inc = false;
                int pcn = __builtin_popcount(cn);
                hrow_new |= (uint32_t)(pcn - pcol) << (k - 1);
                col = cn; pcol = pcn;
                // now the final c column (column h+k+1)
                uint64_t res = ~0ULL;
                if (flat && rowh_inc && !((col >> h) & 1)) {             // (iii): increment of column h+k at row h+1 is 0
                    uint32_t cf = lcs_step(col, mrows_c, Ma);
                    if (__builtin_popcount(cf & Mrh) == __builtin_popcount(col & Mrh)) {   // (i) for the last column
                        int pcf = __builtin_popcount(cf);
                        uint32_t hrow = hrow_new | ((uint32_t)(pcf - pcol) << k);   // columns h+1..h+k+1 of row h+1
                        // new y: b[bLen-h+1 .. bLen], b = yr (cols 1..h), cb x k, c
                        uint64_t bfull = (uint64_t)yr | ((uint64_t)(cb ? ((1u << k) - 1) : 0) << h) | ((uint64_t)c << (h + k));
                        const int bL = h + k + 1;
                        uint32_t nyr = (uint32_t)(bfull >> (bL - h)) & Mh;
                        uint32_t nxr = (xr >> 1) | ((uint32_t)c << (h - 1));                  // a[2..h+1]
                        uint32_t ndxr = (cf >> 1) & Mh;                                          // rows 2..h+1 of column bL
                        // row h+1 increments over columns bL-h+1..bL: old columns from H1, new columns from hrow
                        uint64_t rowfull = (uint64_t)H1 | ((uint64_t)hrow << h);                // columns 1..bL
                        uint32_t ndyr = (uint32_t)(rowfull >> (bL - h)) & Mh;
                        uint32_t nx = revh(nxr, h), ny = revh(nyr, h), ndx = revh(ndxr, h), ndy = revh(ndyr, h);
                        if (nx >> (h - 1)) { nx ^= Mh; ny ^= Mh; }
                        res = ((uint64_t)nx << (3 * h)) | ((uint64_t)ny << (2 * h)) | ((uint64_t)ndx << h) | ndy;
                    }
                }
                out[c * L + (-k) + h - 1] = res;
            }
        }
    }
    (void)pdx;
}
