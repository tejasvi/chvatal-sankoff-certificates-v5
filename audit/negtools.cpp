// Helpers for negative tests on large certificates (second checker).
//   negtools find KEYS KEY                 -> index of KEY in the sorted keys file (or -1)
//   negtools patch VFILE INDEX FACTOR      -> v[INDEX] *= FACTOR in place (use on a copy)
//   negtools drop KEYS V INDEX OUTK OUTV   -> copies without entry INDEX
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <vector>
#include <algorithm>

int main(int argc, char **argv) {
    if (argc < 2) return 2;
    if (!strcmp(argv[1], "find")) {
        FILE *f = fopen(argv[2], "rb"); fseek(f, 0, SEEK_END); long long n = ftell(f) / 8;
        uint64_t key = strtoull(argv[3], nullptr, 10); long long lo = 0, hi = n - 1;
        while (lo <= hi) { long long mid = (lo + hi) / 2; uint64_t k; fseek(f, mid * 8, SEEK_SET); if (fread(&k, 8, 1, f) != 1) return 1;
            if (k == key) { printf("%lld\n", mid); return 0; } if (k < key) lo = mid + 1; else hi = mid - 1; }
        printf("-1\n"); return 0;
    }
    if (!strcmp(argv[1], "patch")) {
        FILE *f = fopen(argv[2], "r+b"); long long idx = atoll(argv[3]); double fac = atof(argv[4]), v;
        fseek(f, idx * 8, SEEK_SET); if (fread(&v, 8, 1, f) != 1) return 1; double nv = v * fac;
        fseek(f, idx * 8, SEEK_SET); fwrite(&nv, 8, 1, f); fclose(f);
        printf("v[%lld]: %.17g -> %.17g\n", idx, v, nv); return 0;
    }
    if (!strcmp(argv[1], "drop")) {
        long long idx = atoll(argv[4]);
        for (int w = 0; w < 2; w++) {
            FILE *in = fopen(argv[2 + w], "rb"), *out = fopen(argv[5 + w], "wb");
            std::vector<char> buf(1 << 26); long long pos = 0; size_t r;
            while ((r = fread(buf.data(), 1, buf.size(), in)) > 0) {
                long long a = pos, b = pos + (long long)r, cut = idx * 8;
                if (cut >= a && cut < b) { long long o = cut - a; fwrite(buf.data(), 1, o, out); fwrite(buf.data() + o + 8, 1, r - o - 8, out); }
                else fwrite(buf.data(), 1, r, out);
                pos = b;
            }
            fclose(in); fclose(out);
        }
        printf("dropped entry %lld\n", idx); return 0;
    }
    return 2;
}
