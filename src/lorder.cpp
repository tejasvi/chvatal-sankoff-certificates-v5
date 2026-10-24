// lorder.cpp: breadth-first numbering of M_h in Lueker's order (start = 1; states processed in id order; inputs in
// the order c = 0,1 and l = -(h-1)..h-1; a new state gets the next id), streamed to stdout in the little-endian
// table layout used by J2026 (int32 h, int32 N; N rows of 2(2h-1) uint32 successor ids, 0 = reject; then N uint64
// keys in id order), so that its SHA-256 can be compared with the published sums.  Uses mh_delta.h.
//   lorder H EXPECTED_N  | sha256sum
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <vector>
#include <omp.h>
#include "mh_delta.h"

static inline uint64_t mix64(uint64_t z) {
    z += 0x9e3779b97f4a7c15ULL; z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL; return z ^ (z >> 31);
}

int main(int argc, char **argv) {
    int h = atoi(argv[1]); uint64_t expN = strtoull(argv[2], 0, 10);
    const int NT = 2 * (2 * h - 1);
    uint64_t cap = 1; while (cap < expN * 2 + 16) cap <<= 1;
    std::vector<uint64_t> hk(cap, ~0ULL); std::vector<uint32_t> hv(cap, 0);
    std::vector<uint64_t> states(1); states.reserve(expN + 2);
    auto find_or_add = [&](uint64_t k) -> uint32_t {
        uint64_t p = mix64(k) & (cap - 1);
        while (true) {
            if (hk[p] == k) return hv[p];
            if (hk[p] == ~0ULL) { states.push_back(k); hk[p] = k; hv[p] = (uint32_t)(states.size() - 1); return hv[p]; }
            p = (p + 1) & (cap - 1);
        }
    };
    static char obuf[1 << 24]; setvbuf(stdout, obuf, _IOFBF, sizeof obuf);
    int32_t hdr[2] = {h, (int32_t)expN}; fwrite(hdr, 4, 2, stdout);
    find_or_add((((1ULL << h) - 1) << h) | ((1ULL << h) - 1));
    const uint64_t BLK = 1 << 20;
    std::vector<uint64_t> buf; std::vector<uint32_t> row(NT);
    uint64_t s0 = 1; double t0 = omp_get_wtime();
    while (s0 < states.size()) {
        uint64_t s1 = std::min<uint64_t>(states.size(), s0 + BLK);
        buf.resize((s1 - s0) * NT);
#pragma omp parallel for schedule(dynamic, 256)
        for (uint64_t s = s0; s < s1; s++) {
            int k = 0;
            for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++) buf[(s - s0) * NT + k++] = delta_dp(h, states[s], c, l);
        }
        for (uint64_t s = s0; s < s1; s++) {
            for (int k = 0; k < NT; k++) { uint64_t t = buf[(s - s0) * NT + k]; row[k] = (t == REJECT) ? 0 : find_or_add(t); }
            fwrite(row.data(), 4, NT, stdout);
        }
        s0 = s1;
        fprintf(stderr, "  processed %llu / discovered %zu (%.0fs)\n", (unsigned long long)s0 - 1, states.size() - 1, omp_get_wtime() - t0);
    }
    uint64_t N = states.size() - 1;
    fwrite(states.data() + 1, 8, N, stdout);
    fflush(stdout);
    fprintf(stderr, "N=%llu expected=%llu %s\n", (unsigned long long)N, (unsigned long long)expN, N == expN ? "OK" : "MISMATCH (header wrong)");
    return N == expN ? 0 : 1;
}
