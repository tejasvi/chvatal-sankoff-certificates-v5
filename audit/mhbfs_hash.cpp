// Audit: reachable state set of Lueker's automaton M_h by a parallel level-synchronous BFS with a lock-free
// open-addressing hash set (CAS on 64-bit slots), using the audit checker's transition function (mh_audit_delta.h).
// EMPTY = ~0: a reduced state never has the top bit of x set, so that key never occurs.
// Writes the sorted keys (little-endian uint64, the certificates' layout); prints the state count and the number of
// accepted transitions (each state is expanded exactly once).
// Build: g++ -O2 -fopenmp -o mhbfs_hash mhbfs_hash.cpp      Usage: mhbfs_hash h log2_slots out_keys.bin [threads]
#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>
#include <parallel/algorithm>
#include <omp.h>
#include "mh_audit_delta.h"

static uint64_t *tab; static uint64_t tmask;
static const uint64_t EMPTY = ~0ULL;

static inline uint64_t mix(uint64_t x) { x ^= x >> 33; x *= 0xff51afd7ed558ccdULL; x ^= x >> 33; x *= 0xc4ceb9fe1a85ec53ULL; x ^= x >> 33; return x; }
static inline bool insert(uint64_t key) {
    uint64_t p = mix(key) & tmask;
    for (;;) {
        uint64_t cur = __atomic_load_n(&tab[p], __ATOMIC_RELAXED);
        if (cur == key) return false;
        if (cur == EMPTY) {
            uint64_t prev = __sync_val_compare_and_swap(&tab[p], EMPTY, key);
            if (prev == EMPTY) return true;
            if (prev == key) return false;
        }
        p = (p + 1) & tmask;
    }
}

int main(int argc, char **argv) {
    H = atoi(argv[1]); const int h = H;
    const int lg = atoi(argv[2]);
    if (argc > 4) omp_set_num_threads(atoi(argv[4]));
    const uint64_t nslots = 1ULL << lg; tmask = nslots - 1;
    tab = (uint64_t *)malloc(nslots * 8);
    if (!tab) { fprintf(stderr, "cannot allocate the hash table\n"); return 1; }
#pragma omp parallel for schedule(static)
    for (uint64_t i = 0; i < nslots; i++) tab[i] = EMPTY;
    const uint64_t m = (1ULL << h) - 1;
    std::vector<uint64_t> frontier{(m << h) | m};
    insert(frontier[0]);
    unsigned long long accepted = 0, nstates = 1; int level = 0;
    while (!frontier.empty()) {
        int T = omp_get_max_threads();
        std::vector<std::vector<uint64_t>> loc(T);
        unsigned long long acc = 0, added = 0;
#pragma omp parallel reduction(+:acc, added)
        {
            auto &L = loc[omp_get_thread_num()];
#pragma omp for schedule(dynamic, 4096)
            for (size_t i = 0; i < frontier.size(); i++)
                for (int c = 0; c < 2; c++) for (int l = -(h - 1); l <= h - 1; l++) {
                    uint64_t t;
                    if (!delta(frontier[i], c, l, &t)) continue;
                    acc++;
                    if (insert(t)) { L.push_back(t); added++; }
                }
        }
        accepted += acc; nstates += added;
        if (nstates * 10 > nslots * 9) { fprintf(stderr, "hash table above 90%% load\n"); return 1; }
        size_t tot = 0; for (auto &L : loc) tot += L.size();
        std::vector<uint64_t> nf; nf.reserve(tot);
        for (auto &L : loc) { nf.insert(nf.end(), L.begin(), L.end()); std::vector<uint64_t>().swap(L); }
        frontier.swap(nf);
        fprintf(stderr, "level %d: frontier %zu, states %llu, accepted so far %llu\n", ++level, frontier.size(), nstates, accepted);
    }
    // extract, sort, write
    int T = omp_get_max_threads();
    std::vector<uint64_t> cnt(T + 1, 0);
#pragma omp parallel
    {
        int t = omp_get_thread_num(); uint64_t c = 0;
#pragma omp for schedule(static)
        for (uint64_t i = 0; i < nslots; i++) if (tab[i] != EMPTY) c++;
        cnt[t + 1] = c;
    }
    for (int t = 0; t < T; t++) cnt[t + 1] += cnt[t];
    if (cnt[T] != nstates) { fprintf(stderr, "count mismatch %llu vs %llu\n", (unsigned long long)cnt[T], nstates); return 1; }
    std::vector<uint64_t> keys(nstates);
#pragma omp parallel
    {
        int t = omp_get_thread_num(); uint64_t o = cnt[t];
#pragma omp for schedule(static)
        for (uint64_t i = 0; i < nslots; i++) if (tab[i] != EMPTY) keys[o++] = tab[i];
    }
    free(tab);
    __gnu_parallel::sort(keys.begin(), keys.end());
    for (size_t i = 1; i < keys.size(); i++) if (keys[i] <= keys[i - 1]) { fprintf(stderr, "duplicate after sort\n"); return 1; }
    FILE *o = fopen(argv[3], "wb"); if (!o) { perror(argv[3]); return 1; }
    size_t d = 0; while (d < keys.size()) { size_t k = fwrite(keys.data() + d, 8, std::min(keys.size() - d, (size_t)1 << 26), o); if (!k) { perror("write"); return 1; } d += k; }
    fclose(o);
    printf("h=%d states=%llu accepted_transitions=%llu levels=%d\n", h, nstates, accepted, level);
    return 0;
}
