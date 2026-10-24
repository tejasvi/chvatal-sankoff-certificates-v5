// tools_compact13.cpp: convert a certificate (sorted keys + values) to the compact layout read by
// CS31aCert/Check13.lean (`Cert13`).
//
//   compact13 KEYS VEC SB LB NB TB OUTPREFIX [--f64-to-f32] [--no-vec] [--no-sha] [--drop-cache]
//
//   KEYS  : n sorted distinct uint64 state codes, little-endian (8 n bytes)
//   VEC   : n IEEE binary32 bit patterns (4 n bytes, copied), or with --f64-to-f32 (tests only) n IEEE binary64 values
//           (8 n bytes), each rounded to the nearest binary32 (round-half-even, the default FP rounding mode)
//   SB    : number of low key bits stored per entry; LB : bytes per low entry (SB <= 8 LB, LB <= 8)
//   NB    : number of buckets (key >> SB < NB is checked); TB : bytes per table entry (n < 2^(8 TB), TB <= 8)
//
// Output (all little-endian):
//   OUTPREFIX.low : entry i = key_i mod 2^SB in LB bytes                      (n LB bytes)
//   OUTPREFIX.tab : entry b = first index i with key_i >> SB >= b, b = 0..NB  ((NB + 1) TB bytes; tab[0] = 0,
//                   tab[NB] = n)
//   OUTPREFIX.vec : entry i = binary32 bit pattern of value i                 (4 n bytes)
//   With --no-vec, VEC is only size-checked and OUTPREFIX.vec is not written (for binary32 input it would be a byte copy
//   of VEC: use VEC itself, e.g. as a hard link).
//
// Checks: input sizes, keys strictly increasing, every key < NB << SB, the parameter bounds above.  Exit code 2 on a
// failed check (the outputs are then incomplete).  Prints n, the largest bucket, value-pattern statistics (patterns that
// Check13 maps to 0, i.e. zero, negative, infinite or NaN, make their rows fail), the sha256 of the three outputs
// (computed while writing; --no-sha skips it) and the throughput.
//
// Single-threaded streaming: the inputs are mapped in windows of 2^24 entries (bounded address space, so it works for
// inputs of any size, e.g. 1.3 TB), the outputs are written through 16 MiB buffers.  --drop-cache releases the page cache
// of each input window after use (posix_fadvise DONTNEED).
//
// Build: g++ -O2 -o compact13 tools_compact13.cpp
//        (optional, faster sha256 through OpenSSL/SHA-NI: g++ -O2 -DUSE_OPENSSL -o compact13 tools_compact13.cpp -lcrypto)
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cerrno>
#include <string>
#include <chrono>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#ifdef USE_OPENSSL
#include <openssl/evp.h>
#endif

#if !defined(__BYTE_ORDER__) || __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
#error "little-endian host required"
#endif

typedef unsigned __int128 u128;

[[noreturn]] __attribute__((format(printf, 1, 2))) static void die(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    fputc('\n', stderr);
    exit(1);
}

[[noreturn]] static void fail(const char *what, unsigned long long i, unsigned long long k) {
    fprintf(stderr, "FAIL %s at index %llu (key %llu = 0x%llx)\n", what, i, k, k);
    exit(2);
}

// ------------------------------------------------------------------------------------------------------------------
// SHA-256 (FIPS 180-4)
#ifdef USE_OPENSSL
struct Sha256 {
    EVP_MD_CTX *c;
    Sha256() {
        c = EVP_MD_CTX_new();
        if (!c || !EVP_DigestInit_ex(c, EVP_sha256(), nullptr)) die("EVP init failed");
    }
    void update(const uint8_t *p, size_t n) { EVP_DigestUpdate(c, p, n); }
    void final(uint8_t out[32]) {
        unsigned int l = 0;
        EVP_DigestFinal_ex(c, out, &l);
        EVP_MD_CTX_free(c);
    }
};
#else
struct Sha256 {
    uint32_t H[8];
    uint64_t len = 0;
    uint8_t buf[64];
    size_t bl = 0;
    Sha256() {
        static const uint32_t I[8] = {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
                                      0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
        memcpy(H, I, sizeof H);
    }
    static inline uint32_t rotr(uint32_t x, int n) { return (x >> n) | (x << (32 - n)); }
    void block(const uint8_t *p) {
        static const uint32_t K[64] = {
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
            0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
            0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
            0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
            0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
            0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
            0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
            0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
        uint32_t w[64];
        for (int i = 0; i < 16; i++)
            w[i] = (uint32_t)p[4 * i] << 24 | (uint32_t)p[4 * i + 1] << 16 | (uint32_t)p[4 * i + 2] << 8 |
                   (uint32_t)p[4 * i + 3];
        for (int i = 16; i < 64; i++) {
            const uint32_t s0 = rotr(w[i - 15], 7) ^ rotr(w[i - 15], 18) ^ (w[i - 15] >> 3);
            const uint32_t s1 = rotr(w[i - 2], 17) ^ rotr(w[i - 2], 19) ^ (w[i - 2] >> 10);
            w[i] = w[i - 16] + s0 + w[i - 7] + s1;
        }
        uint32_t a = H[0], b = H[1], c = H[2], d = H[3], e = H[4], f = H[5], g = H[6], h = H[7];
        for (int i = 0; i < 64; i++) {
            const uint32_t t1 = h + (rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25)) + ((e & f) ^ (~e & g)) + K[i] + w[i];
            const uint32_t t2 = (rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22)) + ((a & b) ^ (a & c) ^ (b & c));
            h = g; g = f; f = e; e = d + t1; d = c; c = b; b = a; a = t1 + t2;
        }
        H[0] += a; H[1] += b; H[2] += c; H[3] += d; H[4] += e; H[5] += f; H[6] += g; H[7] += h;
    }
    void update(const uint8_t *p, size_t n) {
        len += n;
        if (bl) {
            const size_t k = n < 64 - bl ? n : 64 - bl;
            memcpy(buf + bl, p, k);
            bl += k; p += k; n -= k;
            if (bl < 64) return;
            block(buf);
            bl = 0;
        }
        for (; n >= 64; p += 64, n -= 64) block(p);
        if (n) { memcpy(buf, p, n); bl = n; }
    }
    void final(uint8_t out[32]) {
        const uint64_t bits = len * 8;
        const uint8_t one = 0x80, zero = 0;
        update(&one, 1);
        while (bl != 56) update(&zero, 1);
        uint8_t L[8];
        for (int i = 0; i < 8; i++) L[i] = (uint8_t)(bits >> (56 - 8 * i));
        update(L, 8);
        for (int i = 0; i < 8; i++) {
            out[4 * i] = (uint8_t)(H[i] >> 24); out[4 * i + 1] = (uint8_t)(H[i] >> 16);
            out[4 * i + 2] = (uint8_t)(H[i] >> 8); out[4 * i + 3] = (uint8_t)H[i];
        }
    }
};
#endif

// ------------------------------------------------------------------------------------------------------------------
// Buffered output with a running sha256.
struct Writer {
    std::string path;
    int fd = -1;
    uint8_t *buf = nullptr;
    size_t cap = (size_t)16 << 20, n = 0;
    uint64_t total = 0;
    bool dosha;
    Sha256 sha;
    uint8_t digest[32];
    Writer(const std::string &p, bool s) : path(p), dosha(s) {
        fd = open(p.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0644);
        if (fd < 0) die("cannot create %s: errno %llu", p.c_str(), (unsigned long long)errno);
        buf = (uint8_t *)malloc(cap + 16);
        if (!buf) die("out of memory");
    }
    void flush() {
        if (dosha) sha.update(buf, n);
        size_t off = 0;
        while (off < n) {
            const ssize_t r = write(fd, buf + off, n - off);
            if (r < 0 && errno == EINTR) continue;
            if (r <= 0) die("write error on %s: errno %llu", path.c_str(), (unsigned long long)errno);
            off += (size_t)r;
        }
        total += n;
        n = 0;
    }
    inline void put(uint64_t v, int w) {   // w <= 8 bytes, little-endian
        if (n + 8 > cap) flush();
        memcpy(buf + n, &v, 8);            // the buffer has slack; only w bytes are kept
        n += (size_t)w;
    }
    void finish() {
        flush();
        if (close(fd)) die("close error on %s: errno %llu", path.c_str(), (unsigned long long)errno);
        if (dosha) sha.final(digest);
        free(buf);
    }
    void print_sha() const {
        for (int i = 0; i < 32; i++) printf("%02x", digest[i]);
        printf("  %s\n", path.c_str());
    }
};

// ------------------------------------------------------------------------------------------------------------------
static bool parse_u64(const char *s, uint64_t &out) {
    if (!s || !*s || s[0] == '-') return false;
    char *e = nullptr;
    errno = 0;
    const unsigned long long v = strtoull(s, &e, 0);
    if (errno || *e) return false;
    out = v;
    return true;
}

static size_t file_size(int fd, const char *path) {
    struct stat st;
    if (fstat(fd, &st)) die("cannot stat %s: errno %llu", path, (unsigned long long)errno);
    return (size_t)st.st_size;
}

// A read-only mapping of bytes [off, off + len) of fd (off a multiple of the page size).
static const uint8_t *map_window(int fd, size_t off, size_t len, const char *path) {
    if (!len) return nullptr;
    void *p = mmap(nullptr, len, PROT_READ, MAP_PRIVATE, fd, (off_t)off);
    if (p == MAP_FAILED) die("mmap failed on %s: errno %llu", path, (unsigned long long)errno);
    madvise(p, len, MADV_SEQUENTIAL);
    madvise(p, len, MADV_WILLNEED);
    return (const uint8_t *)p;
}

static void usage() {
    fprintf(stderr, "usage: compact13 KEYS VEC SB LB NB TB OUTPREFIX [--f64-to-f32] [--no-vec] [--no-sha] "
                    "[--drop-cache]\n");
    exit(1);
}

int main(int argc, char **argv) {
    const char *posv[7];
    int np = 0;
    bool f64 = false, dosha = true, drop = false, novec = false;
    for (int k = 1; k < argc; k++) {
        if (!strcmp(argv[k], "--f64-to-f32")) f64 = true;
        else if (!strcmp(argv[k], "--no-sha")) dosha = false;
        else if (!strcmp(argv[k], "--no-vec")) novec = true;
        else if (!strcmp(argv[k], "--drop-cache")) drop = true;
        else if (argv[k][0] == '-' && argv[k][1] == '-') usage();
        else if (np < 7) posv[np++] = argv[k];
        else usage();
    }
    if (np != 7) usage();
    uint64_t SB, LB, NB, TB;
    if (!parse_u64(posv[2], SB) || !parse_u64(posv[3], LB) || !parse_u64(posv[4], NB) || !parse_u64(posv[5], TB)) usage();
    if (LB < 1 || LB > 8 || TB < 1 || TB > 8 || SB > 8 * LB || SB > 63 || NB < 1 || NB >= ((uint64_t)1 << 62))
        die("bad parameters (need 1 <= LB <= 8, 1 <= TB <= 8, SB <= min(8 LB, 63), 1 <= NB < 2^62)");
    const u128 KLIM = (u128)NB << SB;                  // every key must be < NB << SB
    const uint64_t LOWMASK = SB ? (((uint64_t)1 << SB) - 1) : 0;
    const u128 NLIM = (u128)1 << (8 * TB);             // table entries (indices <= n) must fit in TB bytes

    const char *kpath = posv[0], *vpath = posv[1];
    const int kfd = open(kpath, O_RDONLY);
    if (kfd < 0) die("cannot open %s: errno %llu", kpath, (unsigned long long)errno);
    const int vfd = open(vpath, O_RDONLY);
    if (vfd < 0) die("cannot open %s: errno %llu", vpath, (unsigned long long)errno);
    const size_t ksz = file_size(kfd, kpath), vsz = file_size(vfd, vpath);
    const size_t vb = f64 ? 8 : 4;
    if (ksz % 8) die("%s: size not a multiple of 8 (%llu bytes)", kpath, (unsigned long long)ksz);
    const uint64_t n = ksz / 8;
    if (vsz != n * vb) {
        fprintf(stderr, "size mismatch: %llu keys but %llu value bytes (expected %llu)\n", (unsigned long long)n,
                (unsigned long long)vsz, (unsigned long long)(n * vb));
        return 1;
    }
    if ((u128)n >= NLIM) die("n = %llu does not fit in TB bytes", (unsigned long long)n);

    const std::string pre = posv[6];
    Writer low(pre + ".low", dosha), tab(pre + ".tab", dosha);
    Writer *vec = novec ? nullptr : new Writer(pre + ".vec", dosha);
    const auto t0 = std::chrono::steady_clock::now();

    const uint64_t WIN = (uint64_t)1 << 24;            // entries per input window (offsets stay page-aligned)
    uint64_t prev = 0, nextb = 0, curb = ~(uint64_t)0, cursz = 0, maxb = 0, maxbk = 0;
    uint64_t nzero = 0, nneg = 0, ninf = 0, nnan = 0, nsub = 0;   // value-pattern statistics (binary32 outputs)
    for (uint64_t i0 = 0; i0 < n; i0 += WIN) {
        const uint64_t i1 = n - i0 < WIN ? n : i0 + WIN, m = i1 - i0;
        const uint8_t *kp = map_window(kfd, i0 * 8, m * 8, kpath);
        const uint8_t *vp = novec ? nullptr : map_window(vfd, i0 * vb, m * vb, vpath);
        for (uint64_t j = 0; j < m; j++) {
            const uint64_t i = i0 + j;
            uint64_t k;
            memcpy(&k, kp + 8 * j, 8);
            if (i && k <= prev) fail("keys not strictly increasing", i, k);
            if ((u128)k >= KLIM) fail("key >= NB << SB", i, k);
            prev = k;
            const uint64_t b = k >> SB;
            while (nextb <= b) { tab.put(i, (int)TB); nextb++; }   // tab[b'] = i for the buckets b' up to b
            if (b == curb) cursz++;
            else {
                if (cursz > maxb) { maxb = cursz; maxbk = curb; }
                curb = b; cursz = 1;
            }
            low.put(k & LOWMASK, (int)LB);
            if (novec) continue;
            uint32_t v;
            if (f64) {
                double d;
                memcpy(&d, vp + 8 * j, 8);
                const float f = (float)d;
                memcpy(&v, &f, 4);
            } else memcpy(&v, vp + 4 * j, 4);
            const uint32_t E = (v >> 23) & 0xff, F = v & 0x7fffff;
            if (v >> 31) nneg++;
            else if (E == 0xff) { if (F) nnan++; else ninf++; }
            else if (E == 0) { if (F) nsub++; else nzero++; }
            vec->put(v, 4);
        }
        if (m) {
            munmap((void *)kp, m * 8);
            if (vp) munmap((void *)vp, m * vb);
            if (drop) {
                posix_fadvise(kfd, (off_t)(i0 * 8), (off_t)(m * 8), POSIX_FADV_DONTNEED);
                if (vp) posix_fadvise(vfd, (off_t)(i0 * vb), (off_t)(m * vb), POSIX_FADV_DONTNEED);
            }
        }
    }
    if (cursz > maxb) { maxb = cursz; maxbk = curb; }
    while (nextb <= NB) { tab.put(n, (int)TB); nextb++; }  // the remaining buckets, including tab[NB] = n
    close(kfd);
    close(vfd);
    low.finish();
    tab.finish();
    if (vec) vec->finish();
    const uint64_t vtot = vec ? vec->total : 0;
    const double secs = std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count();

    if (low.total != n * LB || tab.total != (NB + 1) * TB || (vec && vtot != n * 4)) die("internal: output size mismatch");
    printf("compact13: n=%llu sb=%llu lb=%llu nb=%llu tb=%llu vec=%s\n", (unsigned long long)n, (unsigned long long)SB,
           (unsigned long long)LB, (unsigned long long)NB, (unsigned long long)TB,
           novec ? "not written (--no-vec)" : f64 ? "binary64 rounded to binary32" : "binary32 copied");
    printf("max_bucket=%llu (bucket %llu)\n", (unsigned long long)maxb, (unsigned long long)maxbk);
    if (!novec)
        printf("values: zero=%llu negative=%llu inf=%llu nan=%llu (rows with these fail in Check13); subnormal=%llu\n",
           (unsigned long long)nzero, (unsigned long long)nneg, (unsigned long long)ninf, (unsigned long long)nnan,
           (unsigned long long)nsub);
    const uint64_t inb = ksz + (novec ? 0 : vsz);   // bytes read
    printf("bytes: in=%llu out=%llu (low %llu, tab %llu, vec %llu)\n", (unsigned long long)inb,
           (unsigned long long)(low.total + tab.total + vtot), (unsigned long long)low.total,
           (unsigned long long)tab.total, (unsigned long long)vtot);
    printf("time=%.2fs in_rate=%.1f MB/s\n", secs, secs > 0 ? (double)inb / 1e6 / secs : 0.0);
    if (dosha) {
        low.print_sha();
        tab.print_sha();
        if (vec) vec->print_sha();
    }
    return 0;
}
