// check2.cpp: second independent exact checker for a Collatz-Wielandt certificate of Lueker's automaton M_h.
//
// Specification: PROGRESS.md, section M2 (window of a state, transition delta steps (1)-(6), start state, weights w_z,
// Theorem 4, Lemma 5).  Certificate semantics, file formats and the exact integer evaluation are those of src/check.cpp,
// so both programs print the same lam_num on the same files.  The transition code is separate: an incremental plain
// dynamic program (successors() below) that computes the windows of all 2(2h-1) inputs of a state with shared work.
//
//   check2 H KEYS VEC WEIGHTS [THREADS] [--rows LO HI] [--segments S] [--f32] [--index-bits B] [--drop-cache] [--no-thp]
//     KEYS    : sorted distinct uint64 state codes x<<3h | y<<2h | dx<<h | dy (h-bit fields, oldest symbol = MSB)
//     VEC     : one IEEE binary64 per state (default), or one IEEE binary32 per state with --f32 (each binary32 value is
//               converted exactly to binary64, by integer operations); every value must be positive (normal as binary64)
//     WEIGHTS : text file with h integers Wt[0..h-1], Wt[k] >= 2^64 w_z(k), k = |l| (cert_weights.py)
//     THREADS : OpenMP thread count (default: OMP_NUM_THREADS)
//     --rows LO HI    : check only the states with index in [LO,HI) of KEYS; successors are looked up in ALL of KEYS.
//                       The global checks (1)-(3) below are always done on the whole input.  A split run certifies
//                       lam = max of the partial lam_num values if the ranges cover [0,N) and all runs pass.
//     --segments S    : process [LO,HI) as S consecutive segments, printing a SEGMENT result line after each (a run
//                       that dies early still certifies its finished segments; restart with --rows on the rest)
//     --f32           : VEC holds binary32 values
//     --index-bits B  : radix index on the top B key bits (default floor(log2 N)+1, at most 32; option up to 36)
//     --drop-cache    : posix_fadvise(DONTNEED) on the input files after reading (releases page cache on big runs)
//     --no-thp        : do not request transparent huge pages for the arrays (default: madvise(MADV_HUGEPAGE))
//
// Checks (identical to check.cpp): (1) keys strictly increasing and < 2^(4h); (2) the start state <0^h,0^h,1^h,1^h> is
// listed; (3) every v entry is positive and normal (as binary64); (4) closure: every accepted successor of every checked
// state is listed; (5) exact evaluation, with v = m 2^e (2^52 <= m < 2^53 integer):
//     S_q = sum_{c,l accepted} ceil(Wt[|l|] m_{q'} 2^(e_{q'} - e_q)),  q' = delta(q,T_{c,l}),
// lam_num = max over checked q of ceil(S_q / m_q) (2^64-1 if some term is >= 2^118), so that on the checked rows
//     sum_{c,l} w_z(l) v(delta(q,T_{c,l})) <= (lam_num / 2^64) v(q)   holds exactly.
// All certificate arithmetic is integer arithmetic (unsigned __int128); no floating-point operation is involved
// (the binary64/binary32 inputs are decoded from their bit patterns).
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cerrno>
#include <vector>
#include <atomic>
#include <algorithm>
#include <omp.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/resource.h>

namespace c2 {

typedef unsigned __int128 u128;
static int h = 0;                       // history length
static uint64_t MK = 0;                 // h-bit mask
static const uint64_t REJ = ~0ULL;      // marker for a rejected input (never a valid key: keys are < 2^60)
enum { MAXH = 15, DIM = 2 * MAXH + 2 };

[[noreturn]] static void internal(const char *what) {
    fprintf(stderr, "internal: %s\n", what);
    exit(3);
}

// Step (3), the LCS recurrence: W(r,s) = W(r-1,s-1) + 1 if a[r] = b[s], else max(W(r-1,s), W(r,s-1)).
static inline int lcs(bool match, int diag, int up, int left) {
    return match ? diag + 1 : (up > left ? up : left);
}

// Window of one state plus the appended symbols.  W[r][s] = window value at row r (string a), column s (string b).
// Boundary (never overwritten): column h for rows 0..h (from dx) and row h for columns 0..h (from dy).
struct Tab {
    int W[DIM][DIM];
    int a[DIM], b[DIM];
};

#ifdef C2_DEBUG
// Debug build (validation harness): every cell outside the boundary is poisoned before each family of inputs, and every
// computed cell is checked for {0,1} increments, so a read of a cell not written for the current family is detected.
static const int POISON = -1000000;
static void poison(Tab &t) {
    for (int r = 0; r < DIM; r++)
        for (int s = 0; s < DIM; s++)
            if (!((s == h && r <= h) || (r == h && s <= h))) t.W[r][s] = POISON;
}
static inline void chk_cell(const Tab &t, int r, int s) {
    const int v = t.W[r][s], d1 = v - t.W[r - 1][s], d2 = v - t.W[r][s - 1];
    if (d1 < 0 || d1 > 1 || d2 < 0 || d2 > 1) internal("cell increment not 0/1 (debug)");
}
#define C2_CHK(t, r, s) chk_cell(t, r, s)
#else
#define C2_CHK(t, r, s) ((void)0)
#endif

// Row r > h of the window, a[r] = sym: step (2) W(r,0) = W(h,0), then step (3) on columns 1..h+1 (b[h+1] is set).
static inline void fill_row(Tab &t, int r, int sym) {
    int *cur = t.W[r];
    const int *up = t.W[r - 1];
    cur[0] = t.W[h][0];
    for (int s = 1; s <= h + 1; s++) {
        cur[s] = lcs(sym == t.b[s], up[s - 1], up[s], cur[s - 1]);
        C2_CHK(t, r, s);
    }
}

// Column s > h of the window, b[s] = sym: step (2) W(0,s) = W(0,h), then step (3) on rows 1..h+1 (a[h+1] is set).
static inline void fill_col(Tab &t, int s, int sym) {
    t.W[0][s] = t.W[0][h];
    for (int r = 1; r <= h + 1; r++) {
        t.W[r][s] = lcs(t.a[r] == sym, t.W[r - 1][s - 1], t.W[r - 1][s], t.W[r][s - 1]);
        C2_CHK(t, r, s);
    }
}

// Steps (4)-(6) for an input whose window is complete in rows 0..aLen, columns 0..bLen.  nx, ny = the last h symbols of
// a and b (computed by the caller).  Returns the reduced successor code, or REJ.
static inline uint64_t finish(const Tab &t, int aLen, int bLen, uint64_t nx, uint64_t ny) {
    int i = aLen, j = bLen, diag = 0;
    for (;;) {                                         // canonical backtrack: up, else left, else diagonal
        if (i < h || j < h) return REJ;
        if (i == h && j == h) break;
        const int v = t.W[i][j];
        if (t.W[i - 1][j] == v) i--;
        else if (t.W[i][j - 1] == v) j--;
        else { i--; j--; diag++; }
    }
    if (diag != 1) internal("accepted backtrack without exactly one diagonal step");
    uint64_t ndx = 0, ndy = 0;
    for (int r = aLen - h + 1; r <= aLen; r++) {       // increments down column bLen
        const int d = t.W[r][bLen] - t.W[r - 1][bLen];
        if (d & ~1) internal("column increment not 0/1");
        ndx = 2 * ndx + (uint64_t)d;
    }
    for (int s = bLen - h + 1; s <= bLen; s++) {       // increments along row aLen
        const int d = t.W[aLen][s] - t.W[aLen][s - 1];
        if (d & ~1) internal("row increment not 0/1");
        ndy = 2 * ndy + (uint64_t)d;
    }
    if (nx >> (h - 1)) { nx ^= MK; ny ^= MK; }         // step (6): first symbol of x must be 0
    return (nx << (3 * h)) | (ny << (2 * h)) | (ndx << h) | ndy;
}

// res[c*(2h-1) + (l+h-1)] = delta(q, T_{c,l}) (REJ if rejected) for c in {0,1}, -(h-1) <= l <= h-1.
//  l >= 0: a gets cbar^l c (rows h+1..h+l+1), b gets c (column h+1).  Column h+1 on rows 1..h and the cbar rows
//          h+1..h+l are common to all l' >= l; per l only the last row (symbol c) is new, and it is then overwritten by
//          a cbar row for l+1.
//  l < 0:  a gets c (row h+1), b gets cbar^L c, L = -l (columns h+1..h+L+1).  Row h+1 on columns 1..h and the cbar
//          columns are common; per L only the last column (symbol c) is new, then overwritten by a cbar column.
// Every cell is computed by the plain LCS recurrence from its three neighbours (step (3)).
static void successors(uint64_t q, uint64_t *res) {
    Tab t;
    const uint64_t dy = q & MK, dx = (q >> h) & MK, y = (q >> (2 * h)) & MK, x = (q >> (3 * h)) & MK;
    for (int i = 1; i <= h; i++) {
        t.a[i] = (int)((x >> (h - i)) & 1);
        t.b[i] = (int)((y >> (h - i)) & 1);
    }
    t.W[h][h] = 2 * DIM;                               // arbitrary offset
    for (int r = h; r >= 1; r--) t.W[r - 1][h] = t.W[r][h] - (int)((dx >> (h - r)) & 1);
    for (int s = h; s >= 1; s--) t.W[h][s - 1] = t.W[h][s] - (int)((dy >> (h - s)) & 1);
    const int n = 2 * h - 1;
    for (int c = 0; c <= 1; c++) {
        const int cb = 1 - c;
        uint64_t *rc = res + c * n + (h - 1);          // rc[l]
        // ---------------- l = 0, 1, ..., h-1 ----------------
#ifdef C2_DEBUG
        poison(t);
#endif
        t.b[h + 1] = c;
        t.W[0][h + 1] = t.W[0][h];
        for (int r = 1; r <= h; r++) {
            t.W[r][h + 1] = lcs(t.a[r] == c, t.W[r - 1][h], t.W[r - 1][h + 1], t.W[r][h]);
            C2_CHK(t, r, h + 1);
        }
        const uint64_t nyr = ((y << 1) | (uint64_t)c) & MK;
        for (int l = 0; l < h; l++) {
            const int R = h + l + 1;                   // rows h+1..R-1 hold cbar
            fill_row(t, R, c);
            const uint64_t tail = (cb ? (((1ULL << l) - 1) << 1) : 0) | (uint64_t)c;   // cbar^l c
            rc[l] = finish(t, R, h + 1, ((x << (l + 1)) | tail) & MK, nyr);
            if (l + 1 < h) fill_row(t, R, cb);
        }
        // ---------------- l = -1, -2, ..., -(h-1) ----------------
#ifdef C2_DEBUG
        poison(t);
#endif
        t.a[h + 1] = c;
        t.W[h + 1][0] = t.W[h][0];
        for (int s = 1; s <= h; s++) {
            t.W[h + 1][s] = lcs(c == t.b[s], t.W[h][s - 1], t.W[h][s], t.W[h + 1][s - 1]);
            C2_CHK(t, h + 1, s);
        }
        const uint64_t nxc = ((x << 1) | (uint64_t)c) & MK;
        for (int L = 1; L < h; L++) {
            fill_col(t, h + L, cb);                    // columns h+1..h+L hold cbar
            fill_col(t, h + L + 1, c);
            const uint64_t tail = (cb ? (((1ULL << L) - 1) << 1) : 0) | (uint64_t)c;   // cbar^L c
            rc[-L] = finish(t, h + 1, h + L + 1, nxc, ((y << (L + 1)) | tail) & MK);
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------
// v = m 2^e with 2^52 <= m < 2^53, decoded from the bit pattern (same (m,e) as frexp in check.cpp).
static const uint64_t *V64 = nullptr;   // binary64 bit patterns
static const uint32_t *V32 = nullptr;   // binary32 bit patterns (--f32)

static inline bool bad64(uint64_t u) {  // not (positive and normal)
    const uint64_t E = (u >> 52) & 0x7ff;
    return (u >> 63) || E == 0 || E == 0x7ff;
}
static inline bool bad32(uint32_t u) {  // not positive finite nonzero (binary32 subnormals are normal binary64 values)
    const uint32_t E = (u >> 23) & 0xff, F = u & 0x7fffff;
    return (u >> 31) || E == 0xff || (E == 0 && F == 0);
}
static inline void dec64(uint64_t u, uint64_t &m, int &e) {
    m = (u & 0xFFFFFFFFFFFFFULL) | (1ULL << 52);
    e = (int)((u >> 52) & 0x7ff) - 1075;
}
static inline void dec32(uint32_t u, uint64_t &m, int &e) {
    const uint32_t E = (u >> 23) & 0xff, F = u & 0x7fffff;
    if (E) {                                           // (2^23 + F) 2^(E-150)
        m = (uint64_t)(0x800000u | F) << 29;
        e = (int)E - 179;
    } else {                                           // F 2^-149, F != 0
        const int p = 31 - __builtin_clz(F);
        m = (uint64_t)F << (52 - p);
        e = -149 - (52 - p);
    }
}
template <bool F32> static inline void decomp(uint64_t j, uint64_t &m, int &e) {
    if (F32) dec32(V32[j], m, e);
    else dec64(V64[j], m, e);
}

// ---------------------------------------------------------------------------------------------------------------
static const uint64_t *K = nullptr;     // keys
static uint64_t N = 0;
static const uint64_t *IDX = nullptr;   // IDX[b] = first p with (K[p] >> SH) >= b, b = 0..2^B
static int TOP = 0, SH = 0, B = 0;      // all keys < 2^TOP; bucket = key >> SH
static uint64_t Wt[MAXH];

static std::atomic<uint64_t> g_msgs(0);
static const uint64_t MAX_MSGS = 1000;

enum { NIN = 2 * (2 * MAXH - 1) };                    // max number of inputs per state

// Prefetch the index entries of the accepted successors (issued one row ahead).
static inline void prefetch_index(const uint64_t *res) {
    const int cnt = 2 * (2 * h - 1);
    for (int k = 0; k < cnt; k++) {
        const uint64_t t = res[k];
        if (t != REJ && !(t >> TOP)) __builtin_prefetch(IDX + (t >> SH));
    }
}

// Successor positions: pos[k] = index of res[k] in K, or REJ if res[k] is rejected or not listed (radix bucket of the
// top B bits, then binary search inside the bucket).  The work is split into stages so that the memory accesses of
// different successors overlap (prefetch hints only).  A wrong index could only cause a spurious closure failure,
// never a wrong value: a position is returned only if K[j] == t, and keys are distinct.
template <bool F32> static inline void locate(const uint64_t *res, uint64_t *pos) {
    const int cnt = 2 * (2 * h - 1);
    uint64_t lo[NIN], hi[NIN];
    for (int k = 0; k < cnt; k++) {
        const uint64_t t = res[k];
        lo[k] = hi[k] = 0;
        if (t == REJ || (t >> TOP)) continue;
        const uint64_t bk = t >> SH;
        lo[k] = IDX[bk];
        hi[k] = IDX[bk + 1];
        if (hi[k] - lo[k] <= 64)                       // small bucket: prefetch all of it, else its middle
            for (uint64_t p = lo[k]; p < hi[k]; p += 8) __builtin_prefetch(K + p);
        else __builtin_prefetch(K + lo[k] + (hi[k] - lo[k]) / 2);
    }
    for (int k = 0; k < cnt; k++) {
        const uint64_t t = res[k];
        pos[k] = REJ;
        if (t == REJ) continue;
        const uint64_t *e = K + hi[k];
        const uint64_t *p = std::lower_bound(K + lo[k], e, t);
        if (p != e && *p == t) {
            pos[k] = (uint64_t)(p - K);
            if (F32) __builtin_prefetch(V32 + pos[k]);
            else __builtin_prefetch(V64 + pos[k]);
        }
    }
}

// One row q = K[i] with successors res: closure and the exact row sum.  Returns ceil(S_q / m_q) as in check.cpp.
template <bool F32> static inline uint64_t eval_row(uint64_t i, const uint64_t *res, uint64_t &nacc, uint64_t &nfail) {
    uint64_t pos[NIN];
    locate<F32>(res, pos);
    const uint64_t q = K[i];
    uint64_t mi; int ei;
    decomp<F32>(i, mi, ei);
    const int n = 2 * h - 1;
    u128 S = 0;
    bool huge = false;
    const u128 LIM = ((u128)1) << 118;                 // any term >= 2^118 exceeds 2^64 m_q (< 2^117)
    for (int c = 0; c <= 1; c++)
        for (int l = -(h - 1); l <= h - 1; l++) {
            const int k = c * n + l + h - 1;
            const uint64_t t = res[k];
            if (t == REJ) continue;
            nacc++;
            const uint64_t j = pos[k];
            if (j == REJ) {
                if (g_msgs.fetch_add(1) < MAX_MSGS) {
#pragma omp critical(c2_msg)
                    fprintf(stderr, "FAIL closure: successor %llx of state %llx (c=%d l=%d) not listed\n",
                            (unsigned long long)t, (unsigned long long)q, c, l);
                }
                nfail++;
                continue;
            }
            if (K[j] != t) internal("lookup returned a different key");
            uint64_t mj; int ej;
            decomp<F32>(j, mj, ej);
            const u128 X = (u128)Wt[l < 0 ? -l : l] * mj;   // < 2^117
            const int sh = ej - ei;
            u128 T;
            if (sh >= 0) {
                if (sh >= 118 || X >= (LIM >> sh)) { huge = true; continue; }   // ratio >= 1: the row fails
                T = X << sh;
            } else if (-sh >= 127) T = 1;                                       // rounds up to one unit
            else T = (X >> (-sh)) + (((X & ((((u128)1) << (-sh)) - 1)) != 0) ? 1 : 0);   // ceil
            S += T;
        }
    if (huge) return ~0ULL;
    u128 Q = S / mi;
    if (S % mi) Q += 1;                                // ceil(S / m_q)
    return (Q >> 64) ? ~0ULL : (uint64_t)Q;
}

// ---------------------------------------------------------------------------------------------------------------
static bool g_thp = true;
static void *alloc_big(size_t bytes) {
    const size_t HP = (size_t)2 << 20;
    size_t len = (bytes + HP - 1) / HP * HP;
    if (!len) len = HP;
    void *p = mmap(nullptr, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
    if (p == MAP_FAILED) { perror("mmap"); exit(1); }
    if (g_thp) madvise(p, len, MADV_HUGEPAGE);
    return p;
}

static size_t file_size(const char *path) {
    struct stat st;
    if (stat(path, &st)) { perror(path); exit(1); }
    return (size_t)st.st_size;
}

static void load_file(const char *path, void *dst, size_t bytes, bool drop) {
    int fd = open(path, O_RDONLY);
    if (fd < 0) { perror(path); exit(1); }
    const size_t CH = (size_t)64 << 20;
    const size_t nch = (bytes + CH - 1) / CH;
    std::atomic<int> bad(0);
#pragma omp parallel for schedule(dynamic, 1)
    for (size_t k = 0; k < nch; k++) {
        const size_t off = k * CH, len = std::min(CH, bytes - off);
        size_t d = 0;
        while (d < len) {
            ssize_t r = pread(fd, (char *)dst + off + d, len - d, (off_t)(off + d));
            if (r < 0 && errno == EINTR) continue;
            if (r <= 0) { bad = 1; break; }
            d += (size_t)r;
        }
        if (drop) posix_fadvise(fd, (off_t)off, (off_t)len, POSIX_FADV_DONTNEED);
    }
    close(fd);
    if (bad) { fprintf(stderr, "read error on %s\n", path); exit(1); }
}

static double cpu_seconds() {                         // process user+sys time (diagnostics only)
    struct rusage ru;
    getrusage(RUSAGE_SELF, &ru);
    return (double)ru.ru_utime.tv_sec + 1e-6 * (double)ru.ru_utime.tv_usec + (double)ru.ru_stime.tv_sec +
           1e-6 * (double)ru.ru_stime.tv_usec;
}

static inline uint64_t mix64(uint64_t z) {             // splitmix64 finalizer (input fingerprints only)
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
}

static bool parse_u64(const char *s, uint64_t &out) {
    if (!s || !*s) return false;
    char *e = nullptr;
    errno = 0;
    unsigned long long v = strtoull(s, &e, 10);
    if (errno || *e || s[0] == '-') return false;
    out = v;
    return true;
}

// Rows [LO,HI) with all threads (dynamic chunks of consecutive rows): lam = max of the row values, arg = smallest row
// attaining it, acc = accepted transitions, fail = closure failures.
static void check_range(bool f32, uint64_t LO, uint64_t HI, uint64_t &lam, uint64_t &arg, uint64_t &acc, uint64_t &fail) {
    std::atomic<uint64_t> next(LO);
    const uint64_t CH = 1024;
    const double t0 = omp_get_wtime();
    double last = t0;
    uint64_t nacc = 0, nfail = 0;
    lam = 0; arg = HI;
#pragma omp parallel reduction(+ : nacc, nfail)
    {
        const bool master = omp_get_thread_num() == 0;
        uint64_t lmax = 0, larg = HI;
        for (;;) {
            const uint64_t i0 = next.fetch_add(CH);
            if (i0 >= HI) break;
            const uint64_t i1 = std::min(HI, i0 + CH);
            // software pipeline: the successors of row i+1 are computed (and their index entries prefetched)
            // before row i is evaluated
            uint64_t rb[2][NIN];
            successors(K[i0], rb[0]);
            prefetch_index(rb[0]);
            for (uint64_t i = i0; i < i1; i++) {
                const int cur = (int)((i - i0) & 1);
                if (i + 1 < i1) {
                    successors(K[i + 1], rb[cur ^ 1]);
                    prefetch_index(rb[cur ^ 1]);
                }
                const uint64_t Lq = f32 ? eval_row<true>(i, rb[cur], nacc, nfail) : eval_row<false>(i, rb[cur], nacc, nfail);
                if (Lq > lmax || (Lq == lmax && i < larg)) { lmax = Lq; larg = i; }
            }
            if (master) {
                const double now = omp_get_wtime();
                if (now - last >= 60) {
                    last = now;
                    const double done = (double)(std::min(HI, i0 + CH) - LO), tot = (double)(HI - LO);
                    fprintf(stderr, "progress: rows %llu-%llu: %.4f%%, %.0fs, eta %.0fs\n", (unsigned long long)LO,
                            (unsigned long long)HI, 100 * done / tot, now - t0, (now - t0) * (tot - done) / (done > 0 ? done : 1));
                }
            }
        }
#pragma omp critical(c2_max)
        if (lmax > lam || (lmax == lam && larg < arg)) { lam = lmax; arg = larg; }
    }
    acc = nacc;
    fail = nfail;
}

static void usage() {
    fprintf(stderr, "usage: check2 H KEYS VEC WEIGHTS [THREADS] [--rows LO HI] [--segments S] [--f32] [--index-bits B] "
                    "[--drop-cache] [--no-thp]\n");
}

static int run(int argc, char **argv) {
    std::vector<const char *> pos;
    uint64_t LO = 0, HI = 0;
    bool have_rows = false, f32 = false, drop = false;
    int ibits = -1;
    uint64_t nseg = 1;
    for (int k = 1; k < argc; k++) {
        if (!strcmp(argv[k], "--rows")) {
            if (k + 2 >= argc || !parse_u64(argv[k + 1], LO) || !parse_u64(argv[k + 2], HI)) { usage(); return 1; }
            have_rows = true; k += 2;
        } else if (!strcmp(argv[k], "--segments")) {
            if (k + 1 >= argc || !parse_u64(argv[k + 1], nseg) || nseg < 1 || nseg > 1000000) { usage(); return 1; }
            k++;
        } else if (!strcmp(argv[k], "--f32")) f32 = true;
        else if (!strcmp(argv[k], "--drop-cache")) drop = true;
        else if (!strcmp(argv[k], "--no-thp")) g_thp = false;
        else if (!strcmp(argv[k], "--index-bits")) {
            uint64_t t;
            if (k + 1 >= argc || !parse_u64(argv[k + 1], t) || t < 1 || t > 36) { usage(); return 1; }
            ibits = (int)t; k++;
        } else if (argv[k][0] == '-' && argv[k][1] == '-') { usage(); return 1; }
        else pos.push_back(argv[k]);
    }
    if (pos.size() < 4 || pos.size() > 5) { usage(); return 1; }
    h = atoi(pos[0]);
    if (h < 2 || h > MAXH) { fprintf(stderr, "bad h\n"); return 1; }
    MK = (1ULL << h) - 1;
    if (pos.size() == 5) {
        uint64_t t;
        if (!parse_u64(pos[4], t) || t < 1 || t > 4096) { usage(); return 1; }
        omp_set_num_threads((int)t);
    }
    const double tl0 = omp_get_wtime();
    const size_t nk = file_size(pos[1]), nv = file_size(pos[2]);
    N = nk / 8;
    const size_t vb = f32 ? 4 : 8;
    if (nk % 8 || nv != N * vb) {
        fprintf(stderr, "size mismatch: %zu keys bytes, %zu vec bytes\n", nk, nv);
        return 1;
    }
    FILE *fw = fopen(pos[3], "r");
    if (!fw) { perror(pos[3]); return 1; }
    for (int k = 0; k < h; k++) {
        unsigned long long t;
        if (fscanf(fw, "%llu", &t) != 1) { fprintf(stderr, "weights file short\n"); return 1; }
        Wt[k] = t;
    }
    fclose(fw);
    uint64_t fpw = 0;
    for (int k = 0; k < h; k++) fpw += mix64(Wt[k] + 0x9E3779B97F4A7C15ULL * (uint64_t)(k + 1));
    if (!have_rows) { LO = 0; HI = N; }
    if (!(LO < HI && HI <= N)) {
        fprintf(stderr, "bad row range [%llu,%llu) for %llu states\n", (unsigned long long)LO, (unsigned long long)HI,
                (unsigned long long)N);
        return 1;
    }
    const bool partial = !(LO == 0 && HI == N);
    uint64_t *Kw = (uint64_t *)alloc_big(nk);
    load_file(pos[1], Kw, nk, drop);
    void *Vw = alloc_big(nv);
    load_file(pos[2], Vw, nv, drop);
    K = Kw;
    if (f32) V32 = (const uint32_t *)Vw;
    else V64 = (const uint64_t *)Vw;
    const double tl1 = omp_get_wtime();

    // (1) keys strictly increasing, all < 2^(4h); input fingerprints
    uint64_t badk = N, fpk = 0, fpv = 0;
#pragma omp parallel for schedule(static) reduction(min : badk) reduction(+ : fpk)
    for (uint64_t i = 0; i < N; i++) {
        if ((K[i] >> (4 * h)) || (i && K[i] <= K[i - 1]))
            if (i < badk) badk = i;
        fpk += mix64(K[i] + 0x9E3779B97F4A7C15ULL * (i + 1));
    }
    if (badk < N) {
        if (K[badk] >> (4 * h)) fprintf(stderr, "FAIL key out of range at %llu\n", (unsigned long long)badk);
        else fprintf(stderr, "FAIL keys not strictly increasing at %llu\n", (unsigned long long)badk);
        return 2;
    }
    // (2) start state <0^h, 0^h, 1^h, 1^h>
    const uint64_t q0 = (MK << h) | MK;
    if (!std::binary_search(K, K + N, q0)) { fprintf(stderr, "FAIL start state missing\n"); return 2; }
    // (3) every v entry positive normal (as binary64)
    uint64_t badv = N;
    if (f32) {
#pragma omp parallel for schedule(static) reduction(min : badv) reduction(+ : fpv)
        for (uint64_t i = 0; i < N; i++) {
            if (bad32(V32[i]) && i < badv) badv = i;
            fpv += mix64((uint64_t)V32[i] + 0x9E3779B97F4A7C15ULL * (i + 1));
        }
    } else {
#pragma omp parallel for schedule(static) reduction(min : badv) reduction(+ : fpv)
        for (uint64_t i = 0; i < N; i++) {
            if (bad64(V64[i]) && i < badv) badv = i;
            fpv += mix64(V64[i] + 0x9E3779B97F4A7C15ULL * (i + 1));
        }
    }
    if (badv < N) { fprintf(stderr, "FAIL v[%llu] not positive normal\n", (unsigned long long)badv); return 2; }

    // radix index on the top B bits (the always-zero top bit of reduced keys is skipped when no key uses it)
    TOP = (K[N - 1] >> (4 * h - 1)) ? 4 * h : 4 * h - 1;
    if (ibits > 0) B = ibits;
    else { B = 64 - __builtin_clzll(N); if (B > 32) B = 32; }
    if (B > TOP) B = TOP;
    SH = TOP - B;
    const uint64_t NBK = 1ULL << B;
    uint64_t *idx = (uint64_t *)alloc_big((NBK + 1) * sizeof(uint64_t));
#pragma omp parallel for schedule(static)
    for (uint64_t p = 0; p < N; p++) {
        const uint64_t b1 = K[p] >> SH, b0 = p ? (K[p - 1] >> SH) + 1 : 0;
        for (uint64_t b = b0; b <= b1; b++) idx[b] = p;
    }
    const uint64_t blast = K[N - 1] >> SH;
#pragma omp parallel for schedule(static)
    for (uint64_t b = blast + 1; b <= NBK; b++) idx[b] = N;
    IDX = idx;
    const double tl2 = omp_get_wtime();
    fprintf(stderr, "check2: h=%d N=%llu rows=[%llu,%llu) %s threads=%d index_bits=%d (top=%d) "
                    "keys_fp=%016llx v_fp=%016llx w_fp=%016llx load=%.1fs checks+index=%.1fs\n",
            h, (unsigned long long)N, (unsigned long long)LO, (unsigned long long)HI, f32 ? "v=binary32" : "v=binary64",
            omp_get_max_threads(), B, TOP, (unsigned long long)fpk, (unsigned long long)fpv, (unsigned long long)fpw,
            tl1 - tl0, tl2 - tl1);

    // main loop: rows [LO,HI), optionally as consecutive segments with one result line each
    uint64_t lam_num = 0, nacc = 0, nfail = 0, arg = HI;   // arg = smallest row index attaining lam_num (diagnostic)
    const double t0 = omp_get_wtime(), c0 = cpu_seconds();
    for (uint64_t sg = 0; sg < nseg; sg++) {
        const uint64_t sLO = LO + (uint64_t)((u128)(HI - LO) * sg / nseg);
        const uint64_t sHI = LO + (uint64_t)((u128)(HI - LO) * (sg + 1) / nseg);
        if (sLO >= sHI) continue;
        uint64_t slam = 0, sarg = sHI, sacc = 0, sfail = 0;
        const double ts = omp_get_wtime();
        check_range(f32, sLO, sHI, slam, sarg, sacc, sfail);
        if (nseg > 1) {
            printf("SEGMENT h=%d rows=%llu-%llu total_states=%llu states=%llu accepted_transitions=%llu "
                   "closure_failures=%llu lam_num=%llu keys_fp=%016llx v_fp=%016llx w_fp=%016llx time=%.1fs\n",
                   h, (unsigned long long)sLO, (unsigned long long)sHI, (unsigned long long)N,
                   (unsigned long long)(sHI - sLO), (unsigned long long)sacc, (unsigned long long)sfail,
                   (unsigned long long)slam, (unsigned long long)fpk, (unsigned long long)fpv, (unsigned long long)fpw,
                   omp_get_wtime() - ts);
            fflush(stdout);
        }
        nacc += sacc;
        nfail += sfail;
        if (slam > lam_num || (slam == lam_num && sarg < arg)) { lam_num = slam; arg = sarg; }
    }
    const double t1 = omp_get_wtime(), c1 = cpu_seconds();
    fprintf(stderr, "check2: main loop %.1fs wall, %.1fs cpu (user+sys)\n", t1 - t0, c1 - c0);
    if (arg < HI)
        fprintf(stderr, "check2: lam_num %llu attained first at row %llu (key %llx)\n", (unsigned long long)lam_num,
                (unsigned long long)arg, (unsigned long long)K[arg]);
    if (nfail) {
        if (nfail > MAX_MSGS) fprintf(stderr, "(only the first %llu closure failures were printed)\n", (unsigned long long)MAX_MSGS);
        printf("FAIL: %llu closure failures\n", (unsigned long long)nfail);
        return 2;
    }
    const double lam_cert = (double)lam_num / 18446744073709551616.0;   // display only
    if (!partial) {
        printf("h=%d states=%llu accepted_transitions=%llu lam_num=%llu lam_cert=%.17g time=%.1fs\n", h,
               (unsigned long long)N, (unsigned long long)nacc, (unsigned long long)lam_num, lam_cert, t1 - t0);
        printf("CLAIM: A_z v <= (%llu / 2^64) v exactly, on a transition-closed state set containing the start state\n",
               (unsigned long long)lam_num);
    } else {
        printf("h=%d rows=%llu-%llu total_states=%llu states=%llu accepted_transitions=%llu lam_num=%llu lam_cert=%.17g "
               "keys_fp=%016llx v_fp=%016llx w_fp=%016llx time=%.1fs\n",
               h, (unsigned long long)LO, (unsigned long long)HI, (unsigned long long)N, (unsigned long long)(HI - LO),
               (unsigned long long)nacc, (unsigned long long)lam_num, lam_cert, (unsigned long long)fpk,
               (unsigned long long)fpv, (unsigned long long)fpw, t1 - t0);
        printf("CLAIM(rows %llu-%llu of %llu): every accepted successor of these states is listed and "
               "(A_z v)(q) <= (%llu / 2^64) v(q) exactly for each of them; keys sorted, start state listed, v > 0 on all "
               "states\n",
               (unsigned long long)LO, (unsigned long long)HI, (unsigned long long)N, (unsigned long long)lam_num);
    }
    return 0;
}

}  // namespace c2

int main(int argc, char **argv) { return c2::run(argc, argv); }
