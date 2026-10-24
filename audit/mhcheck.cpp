// Second checker (independent of the first checker's code) for the Chvatal-Sankoff upper-bound certificate built on Lueker's
// automaton M_h.  Verifies, in exact integer arithmetic:
//   (a) the state list (sorted uint64 keys, key = x<<3h | y<<2h | dx<<h | dy) is strictly increasing and contains
//       q0 = (0^h, 0^h, 1^h, 1^h);
//   (b) closure: every accepted, reduced successor delta(q, T_{c,l}) (c in {0,1}, |l| <= h-1) of every listed state is
//       listed (delta computed HERE from the definition: window DP, constant boundary extension, canonical backtrack);
//   (c) for every state q:  sum_{c,l accepted} W_|l| V(delta(q,T_{c,l}))  <=  LAM * V(q),
//       with W_k = given integers (upper bounds of 2^64 w_z(k), computed by weights_bound.py from the exact rational z),
//       V(q) = v(q) 2^K exactly (v = the given float64 vector, K = 53 - min frexp exponent), LAM = given integer
//       (lambda = LAM / 2^64); all sums in unsigned __int128 (no overflow: checked (Wsum+1) * max V < 2^128, Wsum =
//       sum of the weights over all 2(2h-1) inputs, which bounds every row sum and every ceil numerator).
//   It also reports how many rows fail with LAM - 1 (tightness), the accepted-transition count, and a float estimate of
//   max_q row/V(q).
// Build: g++ -O2 -fopenmp -o mhcheck mhcheck.cpp      Usage: mhcheck h keys.bin v.bin W0,...,W_{h-1} LAM [threads]
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <vector>
#include <string>
#include <algorithm>
#include <omp.h>

#include "mh_audit_delta.h"

static void *slurp(const char *path, size_t *sz) {
    FILE *f = fopen(path, "rb"); if (!f) { perror(path); exit(1); }
    fseek(f, 0, SEEK_END); *sz = (size_t)ftell(f); fseek(f, 0, SEEK_SET);
    void *p = malloc(*sz ? *sz : 1); if (!p) { fprintf(stderr, "oom\n"); exit(1); }
    size_t d = 0; while (d < *sz) { size_t k = fread((char *)p + d, 1, std::min(*sz - d, (size_t)1 << 28), f); if (!k) { perror("read"); exit(1); } d += k; }
    fclose(f); return p;
}

int main(int argc, char **argv) {
    if (argc < 6) { fprintf(stderr, "usage: mhcheck h keys.bin v.bin W0,..,W_{h-1} LAM [threads]\n"); return 2; }
    H = atoi(argv[1]); const int h = H;
    if (h < 2 || h > 15) { fprintf(stderr, "h out of range\n"); return 2; }
    size_t ksz, vsz;
    uint64_t *keys = (uint64_t *)slurp(argv[2], &ksz);
    double *v = (double *)slurp(argv[3], &vsz);
    if (ksz % 8 || vsz % 8 || ksz != vsz) { fprintf(stderr, "file sizes inconsistent\n"); return 1; }
    size_t N = ksz / 8;
    // optional real modification: drop entry MHC_DROP from keys and v (negative test of the state-list checks)
    if (getenv("MHC_DROP")) {
        size_t d = strtoull(getenv("MHC_DROP"), nullptr, 10);
        if (d < N) { memmove(keys + d, keys + d + 1, (N - d - 1) * 8); memmove(v + d, v + d + 1, (N - d - 1) * 8); N--; }
        fprintf(stderr, "MHC_DROP: entry %zu removed\n", d);
    }
    std::vector<uint64_t> Wt;
    { std::string s = argv[4]; size_t p = 0; while (p <= s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); Wt.push_back(strtoull(s.substr(p, q - p).c_str(), nullptr, 10)); p = q + 1; } }
    if ((int)Wt.size() != h) { fprintf(stderr, "need h weights\n"); return 2; }
    // overflow argument: every row sum is at most Wsum * Vmax, Wsum = sum of the weights over all 2(2h-1) inputs
    u128 Wsum = 0;
    for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++) Wsum += (u128)Wt[l < 0 ? -l : l];
    const uint64_t LAM = strtoull(argv[5], nullptr, 10);
    if (argc > 6) omp_set_num_threads(atoi(argv[6]));
    // (a) sorted, unique, start state present
    for (size_t i = 1; i < N; i++) if (keys[i] <= keys[i - 1]) { fprintf(stderr, "keys not strictly increasing at %zu\n", i); return 1; }
    const uint64_t mk = (1ULL << h) - 1, q0 = (mk << h) | mk;
    if (!std::binary_search(keys, keys + N, q0)) { fprintf(stderr, "start state missing\n"); return 1; }
    for (size_t i = 0; i < N; i++) if (keys[i] >> (4 * h)) { fprintf(stderr, "key out of range\n"); return 1; }
    // exact fixed point for v
    int emin = 1 << 30;
    for (size_t i = 0; i < N; i++) {
        if (!(v[i] > 0) || !std::isfinite(v[i])) { fprintf(stderr, "v not positive/finite at %zu\n", i); return 1; }
        int e; frexp(v[i], &e); emin = std::min(emin, e);
    }
    const int K = 53 - emin;
    uint64_t *V = (uint64_t *)v;          // converted in place (same 8 bytes per entry), halving the memory
    for (size_t i = 0; i < N; i++) {
        double t = ldexp(v[i], K);
        if (!(t < 18446744073709551616.0)) { fprintf(stderr, "V overflow\n"); return 1; }
        uint64_t u = (uint64_t)t;
        if ((double)u != t || ldexp((double)u, -K) != v[i]) { fprintf(stderr, "inexact fixed point at %zu\n", i); return 1; }
        V[i] = u;
    }
    uint64_t Vmax = 0;
    for (size_t i = 0; i < N; i++) Vmax = std::max(Vmax, V[i]);
    const u128 U128MAX = ~(u128)0;
    if ((u128)Vmax > U128MAX / (Wsum + 1)) { fprintf(stderr, "(Wsum+1)*Vmax >= 2^128: overflow argument fails\n"); return 1; }
    // optional in-pass negative tests (emulated modifications; the main check is unaffected):
    //   MHC_W2      second weight set (e.g. for a wrong z): count rows with sum2 > LAM V(q)
    //   MHC_PERTURB index p: V'(p) = V(p) - (V(p)/10^12 + 1); count rows failing with V' in place of V
    //   MHC_MISSING index m: count successor lookups that land on m (= missing successors if m were removed)
    std::vector<uint64_t> W2;
    if (getenv("MHC_W2")) { std::string s2 = getenv("MHC_W2"); size_t p = 0; while (p <= s2.size()) { size_t q = s2.find(',', p); if (q == std::string::npos) q = s2.size(); W2.push_back(strtoull(s2.substr(p, q - p).c_str(), nullptr, 10)); p = q + 1; } }
    if (!W2.empty()) {
        if ((int)W2.size() != h) { fprintf(stderr, "MHC_W2 needs h weights\n"); return 2; }
        u128 W2sum = 0; for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++) W2sum += (u128)W2[l < 0 ? -l : l];
        if ((u128)Vmax > U128MAX / (W2sum + 1)) { fprintf(stderr, "MHC_W2 overflow argument fails\n"); return 1; }
    }
    const long long PERT = getenv("MHC_PERTURB") ? atoll(getenv("MHC_PERTURB")) : -1;
    const long long MISS = getenv("MHC_MISSING") ? atoll(getenv("MHC_MISSING")) : -1;
    const uint64_t PDIV = getenv("MHC_PERTURB_DIV") ? strtoull(getenv("MHC_PERTURB_DIV"), nullptr, 10) : 1000000000000ULL;
    const uint64_t Vp = PERT >= 0 ? V[PERT] - (V[PERT] / PDIV + 1) : 0;
    unsigned long long fail2 = 0, fail3 = 0, missing4 = 0;
    unsigned long long accepted = 0, missing = 0, fail = 0, fail_m1 = 0;
    unsigned long long lam_min = 0;      // max over rows of ceil(sum / V(q)): the least LAM that passes every row
    double maxratio = 0.0; size_t argmax = 0;
#pragma omp parallel for schedule(dynamic, 4096) reduction(+:accepted, missing, fail, fail_m1, fail2, fail3, missing4) reduction(max:lam_min)
    for (size_t i = 0; i < N; i++) {
        u128 sum = 0, sum2 = 0, dec3 = 0;
        for (int c = 0; c < 2; c++)
            for (int l = -(h - 1); l <= h - 1; l++) {
                uint64_t t;
                if (!delta(keys[i], c, l, &t)) continue;
                accepted++;
                const uint64_t *p = std::lower_bound(keys, keys + N, t);
                if (p == keys + N || *p != t) { missing++; continue; }
                const size_t j = p - keys;
                sum += (u128)Wt[l < 0 ? -l : l] * (u128)V[j];
                if (!W2.empty()) sum2 += (u128)W2[l < 0 ? -l : l] * (u128)V[j];
                if ((long long)j == PERT) dec3 += (u128)Wt[l < 0 ? -l : l] * (u128)(V[j] - Vp);
                if ((long long)j == MISS) missing4++;
            }
        if (!W2.empty() && sum2 > (u128)LAM * (u128)V[i]) fail2++;
        if (PERT >= 0) { u128 rhs3 = (u128)LAM * (u128)((long long)i == PERT ? Vp : V[i]); if (sum - dec3 > rhs3) fail3++; }
        u128 q = (sum + (u128)V[i] - 1) / (u128)V[i];
        if (q >> 64) { lam_min = ~0ULL; } else if ((unsigned long long)q > lam_min) lam_min = (unsigned long long)q;
        u128 rhs = (u128)LAM * (u128)V[i];
        if (sum > rhs) fail++;
        if (sum > rhs - (u128)V[i]) fail_m1++;
        double ratio = (double)sum / (double)V[i] / 18446744073709551616.0;
        if (ratio > maxratio) {
#pragma omp critical
            { if (ratio > maxratio) { maxratio = ratio; argmax = i; } }
        }
    }
    printf("h=%d states=%zu K=%d accepted_transitions=%llu missing_successors=%llu rows_failing_LAM=%llu "
           "rows_failing_LAM-1=%llu max_ratio_float=%.17g at_key=%llu\n", h, N, K, accepted, missing, fail, fail_m1,
           maxratio, (unsigned long long)keys[argmax]);
    bool ok = (missing == 0 && fail == 0);
    printf("%s: LAM=%llu (lambda = LAM/2^64 = %.17g)\n", ok ? "PASS" : "FAIL", (unsigned long long)LAM, (double)LAM / 18446744073709551616.0);
    printf("least passing LAM (exact, given closure) = %llu (lambda = %.17g); LAM - least = %lld\n", lam_min,
           (double)lam_min / 18446744073709551616.0, (long long)(LAM - lam_min));
    if (!W2.empty()) printf("NEG wrong weights (MHC_W2): rows failing = %llu -> %s\n", fail2, fail2 ? "REJECTED" : "accepted");
    if (PERT >= 0) printf("NEG perturbed V[%lld] (V -= V/%llu + 1): rows failing = %llu -> %s\n", PERT, (unsigned long long)PDIV, fail3, fail3 ? "REJECTED" : "accepted");
    if (MISS >= 0) printf("NEG state %lld removed (emulated): missing successors = %llu -> %s\n", MISS, missing4, missing4 ? "REJECTED" : "accepted");
    return ok ? 0 : 1;
}
