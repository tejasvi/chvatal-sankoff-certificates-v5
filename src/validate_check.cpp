// validate_check.cpp: compare check.cpp's transition function step() with mh_delta.h's delta_dp on every transition of
// every state in KEYS.   validate_check H KEYS
#define main check_main
#include "check.cpp"
#undef main
#include "mh_delta.h"
int main(int argc, char **argv) {
    h = atoi(argv[1]); MK = (1ULL << h) - 1;
    size_t nk; uint64_t *K = (uint64_t *)slurp(argv[2], &nk); uint64_t N = nk / 8, mism = 0, acc = 0;
#pragma omp parallel for schedule(dynamic, 4096) reduction(+:mism, acc)
    for (uint64_t i = 0; i < N; i++)
        for (int c = 0; c <= 1; c++) for (int l = -(h - 1); l <= h - 1; l++) {
            uint64_t t; bool ok = step(K[i], c, l, &t); uint64_t d = delta_dp(h, K[i], c, l);
            if (ok != (d != REJECT) || (ok && t != d)) mism++;
            if (ok) acc++;
        }
    printf("h=%d states=%llu accepted=%llu mismatches(check.cpp vs mh_delta.h)=%llu\n", h, (unsigned long long)N, (unsigned long long)acc, (unsigned long long)mism);
    return mism != 0;
}
