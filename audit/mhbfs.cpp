// Audit BFS of Lueker's automaton M_h with the audit checker's delta (mh_audit_delta.h): Lueker/Jack numbering
// (q0 = 1; states processed in number order; inputs c = 0,1 and l = -(h-1)..h-1; a new successor gets the next number).
// Prints the state count and accepted transitions; with "dump", writes the trans_h<h>.bin layout of Jack (2026) to stdout:
//   int32 {h, N}; N rows of 2(2h-1) uint32 successor numbers (0 = reject); N uint64 keys (x<<3h|y<<2h|dx<<h|dy),
// little-endian, so that `| sha256sum` can be compared with the published SHA-256 of Jack's table.
// Build: g++ -O2 -fopenmp -o mhbfs mhbfs.cpp     Usage: mhbfs h [dump | stream | -] [threads] [N, for stream]
#include <cstdio>
#include <cstring>
#include <vector>
#include <omp.h>
#include "mh_audit_delta.h"

static std::vector<uint64_t> hk; static std::vector<uint32_t> hv; static uint64_t hmask;
static std::vector<uint64_t> states;   // states[0] unused

static inline uint64_t mix(uint64_t x) { x ^= x >> 33; x *= 0xff51afd7ed558ccdULL; x ^= x >> 33; x *= 0xc4ceb9fe1a85ec53ULL; x ^= x >> 33; return x; }
static uint32_t find_or_add(uint64_t key) {
    uint64_t p = mix(key) & hmask;
    while (true) {
        if (hk[p] == ~0ULL) { hk[p] = key; states.push_back(key); hv[p] = (uint32_t)(states.size() - 1); return hv[p]; }
        if (hk[p] == key) return hv[p];
        p = (p + 1) & hmask;
    }
}

int main(int argc, char **argv) {
    H = atoi(argv[1]); const int h = H;
    bool dump = argc > 2 && !strcmp(argv[2], "dump");
    // streaming mode: "stream N" writes the header with the expected state count N first and the rows chunk by chunk
    bool stream = argc > 4 && !strcmp(argv[2], "stream");
    long long expectN = stream ? atoll(argv[4]) : 0;
    if (argc > 3) omp_set_num_threads(atoi(argv[3]));
    if (stream) { int32_t hdr[2] = {h, (int32_t)expectN}; fwrite(hdr, sizeof hdr, 1, stdout); }
    std::vector<uint32_t> chunkrows;
    const int NT = 2 * (2 * h - 1);
    int lg = h <= 6 ? 22 : (h == 7 ? 23 : (h == 8 ? 25 : (h == 9 ? 28 : 30)));
    hk.assign(1ULL << lg, ~0ULL); hv.assign(1ULL << lg, 0); hmask = (1ULL << lg) - 1;
    states.reserve(h >= 10 ? 410000000 : (h == 9 ? 60000000 : 8000000)); states.push_back(0);
    const uint64_t m = (1ULL << h) - 1;
    find_or_add((m << h) | m);
    std::vector<uint32_t> rows; rows.reserve(dump ? (size_t)(h == 9 ? 51500000 : 7000000) * NT : 0);
    unsigned long long accepted = 0;
    const size_t B = 1 << 18;
    std::vector<uint64_t> succ;
    for (size_t s = 1; s < states.size(); ) {
        size_t e = std::min(states.size(), s + B);
        succ.assign((e - s) * NT, ~0ULL);
#pragma omp parallel for schedule(dynamic, 1024)
        for (size_t i = s; i < e; i++) {
            int k = 0;
            for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++, k++) {
                uint64_t t; if (delta(states[i], c, l, &t)) succ[(i - s) * NT + k] = t;
            }
        }
        for (size_t i = s; i < e; i++)
            for (int k = 0; k < NT; k++) {
                uint64_t t = succ[(i - s) * NT + k];
                uint32_t num = 0;
                if (t != ~0ULL) { num = find_or_add(t); accepted++; if (states.size() * 2 > hk.size()) { fprintf(stderr, "hash too small\n"); return 1; } }
                if (dump) rows.push_back(num);
                if (stream) chunkrows.push_back(num);
            }
        if (stream) { fwrite(chunkrows.data(), sizeof(uint32_t), chunkrows.size(), stdout); chunkrows.clear(); }
        s = e;
    }
    const size_t N = states.size() - 1;
    fprintf(stderr, "h=%d states=%zu accepted_transitions=%llu\n", h, N, accepted);
    if (stream) {
        if ((long long)N != expectN) fprintf(stderr, "WARNING: N = %zu differs from the expected %lld (hash will differ)\n", N, expectN);
        fwrite(&states[1], sizeof(uint64_t), N, stdout); fflush(stdout);
    }
    if (dump) {
        int32_t hdr[2] = {h, (int32_t)N};
        fwrite(hdr, sizeof hdr, 1, stdout);
        fwrite(rows.data(), sizeof(uint32_t), rows.size(), stdout);
        fwrite(&states[1], sizeof(uint64_t), N, stdout);
        fflush(stdout);
    }
    return 0;
}
