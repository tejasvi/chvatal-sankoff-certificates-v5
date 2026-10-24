// harness.cpp: validation of check2.cpp against src/check.cpp.
//   harness trans H KEYS      : every input (c,l) of every state in KEYS: check2's successors() vs check.cpp's step()
//                               (accept/reject and successor code); also counts accepted successors not in KEYS.
//   harness f32all            : all 2^32 binary32 bit patterns: check2's bad32/dec32 vs the frexp method of check.cpp
//                               applied to the exactly converted binary64 value.
//   harness f64 VEC [NRAND]   : every binary64 in VEC plus NRAND random bit patterns: bad64/dec64 vs frexp.
// Both checkers are included as they are (their main functions renamed); check2's code lives in namespace c2.
#define main check1_main
#include "../src/check.cpp"
#undef main
#define main check2_main
#include "check2.cpp"
#undef main
#include <random>

// check.cpp's positivity test and decomposition (copied from its main loop)
static bool ref_dec(double t, uint64_t &m, int &e) {
    if (!(t > 0) || !std::isnormal(t)) return false;
    int ex; double f = frexp(t, &ex);
    double mm = ldexp(f, 53);
    m = (uint64_t)mm; e = ex - 53;
    if ((double)m != mm || ldexp((double)m, e) != t) { fprintf(stderr, "ref decomposition failed\n"); exit(3); }
    return true;
}

int main(int argc, char **argv) {
    if (argc >= 4 && !strcmp(argv[1], "trans")) {
        h = atoi(argv[2]); MK = (1ULL << h) - 1;          // check.cpp's globals
        c2::h = h; c2::MK = MK;                           // check2's globals
        size_t nk; uint64_t *Kh = (uint64_t *)slurp(argv[3], &nk); uint64_t Nh = nk / 8;
        const int n = 2 * h - 1;
        uint64_t inputs = 0, acc1 = 0, acc2 = 0, mism = 0, notlisted = 0;
        double t0 = omp_get_wtime();
#pragma omp parallel for schedule(dynamic, 4096) reduction(+ : inputs, acc1, acc2, mism, notlisted)
        for (uint64_t i = 0; i < Nh; i++) {
            uint64_t res[2 * (2 * c2::MAXH - 1)];
            c2::successors(Kh[i], res);
            for (int c = 0; c <= 1; c++)
                for (int l = -(h - 1); l <= h - 1; l++) {
                    uint64_t t1 = 0;
                    bool ok1 = step(Kh[i], c, l, &t1);
                    uint64_t t2 = res[c * n + l + h - 1];
                    bool ok2 = (t2 != c2::REJ);
                    inputs++; acc1 += ok1; acc2 += ok2;
                    if (ok1 != ok2 || (ok1 && t1 != t2)) {
                        if (mism < 10) {
#pragma omp critical
                            fprintf(stderr, "MISMATCH state %llx c=%d l=%d: check %d %llx, check2 %d %llx\n",
                                    (unsigned long long)Kh[i], c, l, ok1, (unsigned long long)t1, ok2, (unsigned long long)t2);
                        }
                        mism++;
                    }
                    if (ok1 && !std::binary_search(Kh, Kh + Nh, t1)) notlisted++;
                }
        }
        printf("trans h=%d states=%llu inputs=%llu accepted(check.cpp)=%llu accepted(check2)=%llu mismatches=%llu "
               "accepted_not_listed=%llu time=%.1fs threads=%d\n",
               h, (unsigned long long)Nh, (unsigned long long)inputs, (unsigned long long)acc1, (unsigned long long)acc2,
               (unsigned long long)mism, (unsigned long long)notlisted, omp_get_wtime() - t0, omp_get_max_threads());
        return mism ? 4 : 0;
    }
    if (argc >= 2 && !strcmp(argv[1], "f32all")) {
        uint64_t pos = 0, rej = 0, mism = 0;
#pragma omp parallel for schedule(static) reduction(+ : pos, rej, mism)
        for (uint64_t u = 0; u < (1ULL << 32); u++) {
            uint32_t w = (uint32_t)u; float f; memcpy(&f, &w, 4);
            double d = (double)f;                          // exact widening conversion
            uint64_t m1 = 0, m2 = 0; int e1 = 0, e2 = 0;
            bool ok1 = ref_dec(d, m1, e1);
            bool ok2 = !c2::bad32(w);
            if (ok2) c2::dec32(w, m2, e2);
            if (ok1) pos++; else rej++;
            if (ok1 != ok2 || (ok1 && (m1 != m2 || e1 != e2))) mism++;
        }
        printf("f32all: accepted=%llu rejected=%llu mismatches=%llu\n", (unsigned long long)pos, (unsigned long long)rej,
               (unsigned long long)mism);
        return mism ? 4 : 0;
    }
    if (argc >= 3 && !strcmp(argv[1], "f64")) {
        size_t nv; uint64_t *Vb = (uint64_t *)slurp(argv[2], &nv); uint64_t Nv = nv / 8;
        uint64_t nrand = argc >= 4 ? strtoull(argv[3], 0, 10) : 0;
        uint64_t pos = 0, rej = 0, mism = 0;
#pragma omp parallel reduction(+ : pos, rej, mism)
        {
            std::mt19937_64 rng(12345 + omp_get_thread_num());
#pragma omp for schedule(static)
            for (uint64_t i = 0; i < Nv + nrand; i++) {
                uint64_t u;
                if (i < Nv) u = Vb[i];
                else {
                    u = rng();
                    int k = (int)(rng() % 8);              // also hit the exponent edge cases
                    if (k == 0) u &= ~(0x7ffULL << 52);
                    if (k == 1) u |= (0x7ffULL << 52);
                    if (k == 2) u = (u & ~(0x7ffULL << 52)) | (1ULL << 52);
                    if (k == 3) u = (u & ~(0x7ffULL << 52)) | (0x7feULL << 52);
                }
                double d; memcpy(&d, &u, 8);
                uint64_t m1 = 0, m2 = 0; int e1 = 0, e2 = 0;
                bool ok1 = ref_dec(d, m1, e1);
                bool ok2 = !c2::bad64(u);
                if (ok2) c2::dec64(u, m2, e2);
                if (ok1) pos++; else rej++;
                if (ok1 != ok2 || (ok1 && (m1 != m2 || e1 != e2))) mism++;
            }
        }
        printf("f64: values=%llu random=%llu accepted=%llu rejected=%llu mismatches=%llu\n", (unsigned long long)Nv,
               (unsigned long long)nrand, (unsigned long long)pos, (unsigned long long)rej, (unsigned long long)mism);
        return mism ? 4 : 0;
    }
    fprintf(stderr, "usage: harness trans H KEYS | f32all | f64 VEC [NRAND]\n");
    return 1;
}
