// walk.cpp: transition-level comparison of check2's successors() with check.cpp's step() on the states visited by
// random walks in M_h from the start state (for h where no key file is available here, e.g. h = 11..15).
//   walk H NWALKS STEPS SEED
// At every visited state all 2(2h-1) inputs are compared; the walk then moves along a uniformly chosen accepted input.
#define main check1_main
#include "../src/check.cpp"
#undef main
#define main check2_main
#include "check2.cpp"
#undef main
#include <random>

int main(int argc, char **argv) {
    if (argc < 5) { fprintf(stderr, "usage: walk H NWALKS STEPS SEED\n"); return 1; }
    h = atoi(argv[1]); MK = (1ULL << h) - 1;
    c2::h = h; c2::MK = MK;
    const uint64_t nw = strtoull(argv[2], 0, 10), steps = strtoull(argv[3], 0, 10), seed = strtoull(argv[4], 0, 10);
    const int n = 2 * h - 1;
    const uint64_t q0 = (MK << h) | MK;
    uint64_t inputs = 0, acc = 0, mism = 0, restarts = 0;
    double t0 = omp_get_wtime();
#pragma omp parallel for schedule(dynamic, 1) reduction(+ : inputs, acc, mism, restarts)
    for (uint64_t w = 0; w < nw; w++) {
        std::mt19937_64 rng(seed * 1000003 + w);
        uint64_t q = q0;
        for (uint64_t s = 0; s < steps; s++) {
            uint64_t res[2 * (2 * c2::MAXH - 1)], succ[2 * (2 * c2::MAXH - 1)];
            int ns = 0;
            c2::successors(q, res);
            for (int c = 0; c <= 1; c++)
                for (int l = -(h - 1); l <= h - 1; l++) {
                    uint64_t t1 = 0;
                    bool ok1 = step(q, c, l, &t1);
                    uint64_t t2 = res[c * n + l + h - 1];
                    bool ok2 = (t2 != c2::REJ);
                    inputs++;
                    if (ok1) { acc++; succ[ns++] = t1; }
                    if (ok1 != ok2 || (ok1 && t1 != t2)) {
                        if (mism < 10) {
#pragma omp critical
                            fprintf(stderr, "MISMATCH state %llx c=%d l=%d: check %d %llx, check2 %d %llx\n",
                                    (unsigned long long)q, c, l, ok1, (unsigned long long)t1, ok2, (unsigned long long)t2);
                        }
                        mism++;
                    }
                }
            if (!ns) { q = q0; restarts++; continue; }
            q = succ[rng() % ns];
        }
    }
    printf("walk h=%d walks=%llu steps=%llu inputs=%llu accepted=%llu mismatches=%llu restarts=%llu time=%.1fs\n", h,
           (unsigned long long)nw, (unsigned long long)steps, (unsigned long long)inputs, (unsigned long long)acc,
           (unsigned long long)mism, (unsigned long long)restarts, omp_get_wtime() - t0);
    return mism ? 4 : 0;
}
