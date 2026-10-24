// validate_fast.cpp: compare mh_fast.h (bit-parallel) with mh_delta.h (direct DP) on every transition of every state
// listed in KEYS, and time both.   validate_fast H KEYS [MAXSTATES]
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <vector>
#include <omp.h>
#include "mh_delta.h"
#include "mh_fast.h"

int main(int argc, char **argv) {
    int h = atoi(argv[1]);
    FILE *f = fopen(argv[2], "rb"); fseek(f, 0, SEEK_END); size_t sz = ftell(f); fseek(f, 0, SEEK_SET);
    uint64_t N = sz / 8; std::vector<uint64_t> K(N); if (fread(K.data(), 8, N, f) != N) return 1; fclose(f);
    if (argc > 3) N = std::min<uint64_t>(N, strtoull(argv[3], 0, 10));
    fast_init();
    const int NI = 2 * (2 * h - 1), L = 2 * h - 1;
    uint64_t mism = 0, acc = 0; double t0 = omp_get_wtime();
#pragma omp parallel for schedule(dynamic, 4096) reduction(+:mism, acc)
    for (uint64_t i = 0; i < N; i++) {
        uint64_t out[64];
        fast_delta_all(h, K[i], out);
        for (int t = 0; t < NI; t++) {
            int c = t / L, l = t % L - (h - 1);
            uint64_t d = delta_dp(h, K[i], c, l);
            if (d != out[t]) {
                if (mism < 5) {
#pragma omp critical
                    fprintf(stderr, "mismatch state %llx c=%d l=%d dp=%llx fast=%llx\n", (unsigned long long)K[i], c, l, (unsigned long long)d, (unsigned long long)out[t]);
                }
                mism++;
            }
            if (d != REJECT) acc++;
        }
    }
    double t1 = omp_get_wtime();
    uint64_t sink = 0;
#pragma omp parallel for schedule(dynamic, 4096) reduction(^:sink)
    for (uint64_t i = 0; i < N; i++) { uint64_t out[64]; fast_delta_all(h, K[i], out); for (int t = 0; t < NI; t++) sink ^= out[t]; }
    double t2 = omp_get_wtime();
#pragma omp parallel for schedule(dynamic, 4096) reduction(^:sink)
    for (uint64_t i = 0; i < N; i++) for (int t = 0; t < NI; t++) sink ^= delta_dp(h, K[i], t / L, t % L - (h - 1));
    double t3 = omp_get_wtime();
    printf("h=%d states=%llu transitions=%llu accepted=%llu mismatches=%llu | time fast %.2fs dp %.2fs (ratio %.1f) [%llx]\n", h,
           (unsigned long long)N, (unsigned long long)N * NI, (unsigned long long)acc, (unsigned long long)mism, t2 - t1, t3 - t2,
           (t3 - t2) / (t2 - t1), (unsigned long long)sink);
    (void)t0;
    return mism ? 1 : 0;
}
