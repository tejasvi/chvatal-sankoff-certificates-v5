// bench.cpp: cost of the transition part alone (no lookups), check2's successors() vs check.cpp's step().
//   bench dp H KEYS     : successors() on every state (all 2(2h-1) inputs)
//   bench step H KEYS   : check.cpp's step() on every input of every state
#define main check1_main
#include "../src/check.cpp"
#undef main
#define main check2_main
#include "check2.cpp"
#undef main

int main(int argc, char **argv) {
    if (argc < 4) { fprintf(stderr, "usage: bench dp|step H KEYS\n"); return 1; }
    h = atoi(argv[2]); MK = (1ULL << h) - 1;
    c2::h = h; c2::MK = MK;
    size_t nk; uint64_t *Kh = (uint64_t *)slurp(argv[3], &nk); uint64_t Nh = nk / 8;
    const int n = 2 * h - 1;
    const bool dp = !strcmp(argv[1], "dp");
    uint64_t sum = 0, acc = 0;
    double t0 = omp_get_wtime();
#pragma omp parallel for schedule(dynamic, 4096) reduction(+ : sum, acc)
    for (uint64_t i = 0; i < Nh; i++) {
        if (dp) {
            uint64_t res[2 * (2 * c2::MAXH - 1)];
            c2::successors(Kh[i], res);
            for (int k = 0; k < 2 * n; k++) if (res[k] != c2::REJ) { sum += res[k]; acc++; }
        } else {
            for (int c = 0; c <= 1; c++)
                for (int l = -(h - 1); l <= h - 1; l++) {
                    uint64_t t;
                    if (step(Kh[i], c, l, &t)) { sum += t; acc++; }
                }
        }
    }
    double dt = omp_get_wtime() - t0;
    printf("bench %s h=%d states=%llu accepted=%llu checksum=%016llx time=%.2fs threads=%d ns/state/thread=%.1f\n",
           argv[1], h, (unsigned long long)Nh, (unsigned long long)acc, (unsigned long long)sum, dt,
           omp_get_max_threads(), dt * 1e9 * omp_get_max_threads() / (double)Nh);
    return 0;
}
