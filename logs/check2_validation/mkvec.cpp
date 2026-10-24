// mkvec.cpp: test inputs for the check2 validation (writes only the named output files).
//   mkvec f32 VEC64 OUT32 OUT64        : binary32 copy of VEC64 (cast, nearest) and the exact binary64 values of it
//   mkvec scale VEC64 OUT64 I NUM DEN  : copy with v[I] replaced by v[I] * NUM / DEN (binary64 arithmetic; test data)
//   mkvec setbits VEC64 OUT64 I HEX    : copy with the bit pattern of v[I] replaced by HEX
//   mkvec drop KEYS VEC64 OUTK OUTV I  : copies with entry I removed from both files
//   mkvec find KEYS KEYHEX             : print the index of a key (or -1)
//   mkvec swapkeys KEYS OUTK I         : copy of KEYS with entries I and I+1 exchanged
//   mkvec setkey KEYS OUTK I HEX       : copy of KEYS with entry I replaced by HEX
//   mkvec setbits32 VEC32 OUT32 I HEX  : copy of a binary32 file with the bit pattern of v[I] replaced by HEX
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <vector>
#include <algorithm>

static std::vector<char> rd(const char *p) {
    FILE *f = fopen(p, "rb"); if (!f) { perror(p); exit(1); }
    fseek(f, 0, SEEK_END); size_t n = ftell(f); fseek(f, 0, SEEK_SET);
    std::vector<char> b(n);
    if (n && fread(b.data(), 1, n, f) != n) { perror("read"); exit(1); }
    fclose(f); return b;
}
static void wr(const char *p, const void *d, size_t n) {
    FILE *f = fopen(p, "wb"); if (!f) { perror(p); exit(1); }
    if (n && fwrite(d, 1, n, f) != n) { perror("write"); exit(1); }
    if (fclose(f)) { perror("close"); exit(1); }
}

int main(int argc, char **argv) {
    if (argc >= 5 && !strcmp(argv[1], "f32")) {
        std::vector<char> b = rd(argv[2]); size_t n = b.size() / 8;
        const double *v = (const double *)b.data();
        std::vector<float> f(n); std::vector<double> d(n);
        for (size_t i = 0; i < n; i++) { f[i] = (float)v[i]; d[i] = (double)f[i]; }
        wr(argv[3], f.data(), n * 4); wr(argv[4], d.data(), n * 8);
        printf("f32: %zu values\n", n); return 0;
    }
    if (argc >= 7 && !strcmp(argv[1], "scale")) {
        std::vector<char> b = rd(argv[2]); double *v = (double *)b.data();
        size_t i = strtoull(argv[4], 0, 10); double num = atof(argv[5]), den = atof(argv[6]);
        printf("scale: v[%zu] = %.17g -> ", i, v[i]); v[i] = v[i] * num / den; printf("%.17g\n", v[i]);
        wr(argv[3], b.data(), b.size()); return 0;
    }
    if (argc >= 6 && !strcmp(argv[1], "setbits")) {
        std::vector<char> b = rd(argv[2]); uint64_t *v = (uint64_t *)b.data();
        size_t i = strtoull(argv[4], 0, 10); uint64_t u = strtoull(argv[5], 0, 16);
        printf("setbits: v[%zu] = %016llx -> %016llx\n", i, (unsigned long long)v[i], (unsigned long long)u); v[i] = u;
        wr(argv[3], b.data(), b.size()); return 0;
    }
    if (argc >= 7 && !strcmp(argv[1], "drop")) {
        std::vector<char> k = rd(argv[2]), v = rd(argv[3]); size_t i = strtoull(argv[6], 0, 10);
        size_t n = k.size() / 8;
        if (v.size() != n * 8 || i >= n) { fprintf(stderr, "bad drop\n"); return 1; }
        printf("drop: index %zu key %llx\n", i, (unsigned long long)((uint64_t *)k.data())[i]);
        k.erase(k.begin() + i * 8, k.begin() + i * 8 + 8); v.erase(v.begin() + i * 8, v.begin() + i * 8 + 8);
        wr(argv[4], k.data(), k.size()); wr(argv[5], v.data(), v.size()); return 0;
    }
    if (argc >= 4 && !strcmp(argv[1], "find")) {
        std::vector<char> k = rd(argv[2]); const uint64_t *K = (const uint64_t *)k.data(); size_t n = k.size() / 8;
        uint64_t key = strtoull(argv[3], 0, 16);
        const uint64_t *p = std::lower_bound(K, K + n, key);
        printf("%lld\n", (p != K + n && *p == key) ? (long long)(p - K) : -1LL); return 0;
    }
    if (argc >= 5 && !strcmp(argv[1], "swapkeys")) {
        std::vector<char> k = rd(argv[2]); uint64_t *K = (uint64_t *)k.data(); size_t i = strtoull(argv[4], 0, 10);
        std::swap(K[i], K[i + 1]); printf("swapkeys: %zu <-> %zu\n", i, i + 1);
        wr(argv[3], k.data(), k.size()); return 0;
    }
    if (argc >= 6 && !strcmp(argv[1], "setkey")) {
        std::vector<char> k = rd(argv[2]); uint64_t *K = (uint64_t *)k.data(); size_t i = strtoull(argv[4], 0, 10);
        uint64_t u = strtoull(argv[5], 0, 16);
        printf("setkey: K[%zu] = %llx -> %llx\n", i, (unsigned long long)K[i], (unsigned long long)u); K[i] = u;
        wr(argv[3], k.data(), k.size()); return 0;
    }
    if (argc >= 6 && !strcmp(argv[1], "setbits32")) {
        std::vector<char> b = rd(argv[2]); uint32_t *v = (uint32_t *)b.data();
        size_t i = strtoull(argv[4], 0, 10); uint32_t u = (uint32_t)strtoul(argv[5], 0, 16);
        printf("setbits32: v[%zu] = %08x -> %08x\n", i, v[i], u); v[i] = u;
        wr(argv[3], b.data(), b.size()); return 0;
    }
    fprintf(stderr, "usage: see source\n"); return 1;
}
