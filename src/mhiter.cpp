// mhiter.cpp: distributed, deterministic power iteration for Lueker's automaton M_h at large h (h = 13).
// One process per machine (rank R of P). Every rank reads the full sorted key file, builds the transition streams
// (in-group ranks, uint16 / uint32, as in mhstream.cpp) for its own contiguous, group-aligned row range, keeps a
// REPLICATED float32 copy of v, computes its own rows in double, rounds them to float32 after normalising by the global
// maximum, and exchanges its slice with the others by a TCP ring all-gather. With -ffp-contract=off the result is
// bit-identical for any P, thread count and resume point (row sums in a fixed order, exact maximum, IEEE rounding).
//
//   mhiter H KEYS Z ITERS OUTDIR R P PEERS PORT [START_IT]
//     PEERS : comma-separated IPv4 addresses of ranks 0..P-1;  PORT: base TCP port (rank r listens on PORT)
//     START_IT: resume from OUTDIR/v_r<R>.f32 written after iteration START_IT (all ranks must use the same value)
//   env MH_LIFT_KEYS, MH_LIFT_V : optional level-(H-1) sorted keys + double vector for the start (else all ones)
//       MH_CKPT (default 25) : checkpoint period;  MH_NS (default 8): parallel TCP streams per ring link
// Output: OUTDIR/v_r<R>.f32 + .it (own slice, every MH_CKPT iterations), and at the end OUTDIR/h<H>_v_<z>.r<R>.f32
// (the full replicated float32 vector, sorted-key order) on every rank.
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <csignal>
#include <ctime>
#include <vector>
#include <string>
#include <thread>
#include <algorithm>
#include <omp.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include "mh_fast.h"

static double now() { return omp_get_wtime(); }
static void die(const char *m) { fprintf(stderr, "FATAL: %s\n", m); fflush(stderr); exit(2); }

// ------------------------------------------------------------------------------------------------ file helpers
static void pread_all(const char *path, void *buf, size_t n, size_t off = 0) {
    int fd = open(path, O_RDONLY); if (fd < 0) { perror(path); die("open"); }
    const size_t CH = (size_t)1 << 30; size_t nch = (n + CH - 1) / CH; int bad = 0;
#pragma omp parallel for schedule(dynamic, 1) num_threads(32) reduction(+:bad)
    for (size_t c = 0; c < nch; c++) {
        size_t a = c * CH, b = std::min(n, a + CH);
        while (a < b) { ssize_t r = pread(fd, (char *)buf + a, b - a, off + a); if (r <= 0) { bad++; break; } a += r; }
    }
    close(fd); if (bad) die("pread failed");
}
static void write_atomic(const std::string &path, const void *buf, size_t n) {
    std::string tmp = path + ".tmp";
    int fd = open(tmp.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0644); if (fd < 0) { perror(tmp.c_str()); die("open w"); }
    const size_t CH = (size_t)1 << 30; size_t nch = (n + CH - 1) / CH; int bad = 0;
#pragma omp parallel for schedule(dynamic, 1) num_threads(16) reduction(+:bad)
    for (size_t c = 0; c < nch; c++) {
        size_t a = c * CH, b = std::min(n, a + CH);
        while (a < b) { ssize_t w = pwrite(fd, (const char *)buf + a, b - a, a); if (w <= 0) { bad++; break; } a += w; }
    }
    if (bad || fsync(fd) || close(fd)) die("write failed");
    if (rename(tmp.c_str(), path.c_str())) die("rename");
}
static size_t fsize(const char *path) { FILE *f = fopen(path, "rb"); if (!f) { perror(path); die("fopen"); } fseek(f, 0, SEEK_END); size_t s = ftell(f); fclose(f); return s; }

// ------------------------------------------------------------------------------------------------ ring network
struct Ring {
    int P = 1, R = 0, NS = 8;
    std::vector<int> nx, pv;   // NS sockets to next rank / from previous rank
    static void sendall(int s, const char *p, size_t n) {
        while (n) { ssize_t w = send(s, p, std::min(n, (size_t)1 << 26), MSG_NOSIGNAL); if (w <= 0) { perror("send"); die("send"); } p += w; n -= w; }
    }
    static void recvall(int s, char *p, size_t n) {
        while (n) { ssize_t r = recv(s, p, std::min(n, (size_t)1 << 26), 0); if (r <= 0) { perror("recv"); die("recv"); } p += r; n -= r; }
    }
    void setup(const std::vector<std::string> &ips, int port) {
        if (P == 1) return;
        int ls = socket(AF_INET, SOCK_STREAM, 0); int one = 1;
        setsockopt(ls, SOL_SOCKET, SO_REUSEADDR, &one, sizeof one);
        sockaddr_in a{}; a.sin_family = AF_INET; a.sin_port = htons(port + R); a.sin_addr.s_addr = INADDR_ANY;
        if (bind(ls, (sockaddr *)&a, sizeof a) || listen(ls, 256)) die("bind/listen");
        int next = (R + 1) % P, prev = (R + P - 1) % P;
        pv.assign(NS, -1); nx.assign(NS, -1);
        std::thread acc([&] {
            for (int k = 0; k < NS; k++) {
                int s = accept(ls, nullptr, nullptr); if (s < 0) die("accept");
                int32_t hdr[2]; recvall(s, (char *)hdr, 8);
                if (hdr[0] != prev || hdr[1] < 0 || hdr[1] >= NS) die("bad ring header");
                int bufsz = 64 << 20; setsockopt(s, SOL_SOCKET, SO_RCVBUF, &bufsz, sizeof bufsz);
                pv[hdr[1]] = s;
            }
        });
        for (int k = 0; k < NS; k++) {
            sockaddr_in b{}; b.sin_family = AF_INET; b.sin_port = htons(port + next);
            inet_pton(AF_INET, ips[next].c_str(), &b.sin_addr);
            int s = -1;
            for (int tries = 0; tries < 14400; tries++) {   // peers may still be building their tables: wait up to 4 h
                s = socket(AF_INET, SOCK_STREAM, 0);
                if (connect(s, (sockaddr *)&b, sizeof b) == 0) break;
                close(s); s = -1; sleep(1);
            }
            if (s < 0) die("connect to next rank");
            int bufsz = 64 << 20; setsockopt(s, SOL_SOCKET, SO_SNDBUF, &bufsz, sizeof bufsz);
            int32_t hdr[2] = {R, k}; sendall(s, (const char *)hdr, 8);
            nx[k] = s;
        }
        acc.join(); close(ls);
        fprintf(stderr, "rank %d: ring connected (%d streams each way)\n", R, NS);
    }
    // all-gather of byte ranges [off[k], off[k]+len[k]) of base, rank k owning range k
    void allgather(char *base, const std::vector<size_t> &off, const std::vector<size_t> &len) {
        if (P == 1) return;
        for (int step = 0; step < P - 1; step++) {
            int sr = (R - step + P) % P, rr = (R - step - 1 + 2 * P) % P;
            std::vector<std::thread> th;
            for (int k = 0; k < NS; k++) {
                size_t sa = len[sr] * k / NS, sb = len[sr] * (k + 1) / NS;
                size_t ra = len[rr] * k / NS, rb = len[rr] * (k + 1) / NS;
                th.emplace_back([=] { sendall(nx[k], base + off[sr] + sa, sb - sa); });
                th.emplace_back([=] { recvall(pv[k], base + off[rr] + ra, rb - ra); });
            }
            for (auto &t : th) t.join();
        }
    }
    // all-gather of one fixed-size record per rank (small); also a barrier
    void allgather_small(const void *mine, size_t rec, void *all) {
        memcpy((char *)all + (size_t)R * rec, mine, rec);
        std::vector<size_t> off(P), len(P, rec); for (int k = 0; k < P; k++) off[k] = (size_t)k * rec;
        allgather((char *)all, off, len);
    }
};

// string part of the successor of group (x,y) under input t, after the complement reduction (as in mhstream.cpp)
static inline uint64_t target_group(int h, uint64_t g, int t) {
    const int L = 2 * h - 1; const uint64_t Mh = (1ULL << h) - 1;
    int c = t / L, l = t % L - (h - 1);
    uint64_t x = g >> h, y = g & Mh, cb = 1 - c, nx, ny;
    if (l >= 0) { uint64_t top = ((cb ? ((1ULL << l) - 1) : 0) << 1) | c; nx = ((x << (l + 1)) | top) & Mh; ny = ((y << 1) | c) & Mh; }
    else { int k = -l; uint64_t bot = ((cb ? ((1ULL << k) - 1) : 0) << 1) | c; nx = ((x << 1) | c) & Mh; ny = ((y << (k + 1)) | bot) & Mh; }
    if (nx >> (h - 1)) { nx ^= Mh; ny ^= Mh; }
    return (nx << h) | ny;
}

static volatile sig_atomic_t g_stop = 0;
static void on_term(int) { g_stop = 1; }

int main(int argc, char **argv) {
    if (argc < 10) { fprintf(stderr, "usage: mhiter H KEYS Z ITERS OUTDIR R P PEERS PORT [START_IT]\n"); return 1; }
    signal(SIGTERM, on_term); signal(SIGINT, on_term);
    fast_init();
    const int h = atoi(argv[1]); const char *keysf = argv[2]; const double z = atof(argv[3]);
    const int iters = atoi(argv[4]); const std::string out = argv[5];
    Ring ring; ring.R = atoi(argv[6]); ring.P = atoi(argv[7]);
    std::vector<std::string> ips; { std::string s = argv[8]; size_t p = 0; while (p <= s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); ips.push_back(s.substr(p, q - p)); p = q + 1; } }
    const int port = atoi(argv[9]); const int start_it = argc > 10 ? atoi(argv[10]) : 0;
    ring.NS = getenv("MH_NS") ? atoi(getenv("MH_NS")) : 8;
    const int ckpt = getenv("MH_CKPT") ? atoi(getenv("MH_CKPT")) : 25;
    if ((int)ips.size() != ring.P) die("PEERS count != P");
    const int R = ring.R, P = ring.P, L = 2 * h - 1, NI = 2 * L, GB = 2 * h;
    const uint64_t NG = 1ULL << GB, LOW = (1ULL << GB) - 1;
    double t0 = now();
    // ---- keys -> group index + low bits
    const size_t nbytes = fsize(keysf); const uint64_t N = nbytes / 8;
    uint64_t *keys = (uint64_t *)malloc(nbytes); if (!keys) die("malloc keys");
    pread_all(keysf, keys, nbytes);
    fprintf(stderr, "rank %d: read %llu keys (%.0fs)\n", R, (unsigned long long)N, now() - t0);
    std::vector<uint64_t> gs(NG + 1, 0);
    for (uint64_t i = 0; i < N; i++) gs[(keys[i] >> GB) + 1]++;     // also checks sortedness below
    for (uint64_t g = 0; g < NG; g++) gs[g + 1] += gs[g];
    { uint64_t bad = 0;
#pragma omp parallel for schedule(static) reduction(+:bad)
      for (uint64_t i = 1; i < N; i++) if (keys[i] <= keys[i - 1]) bad++;
      if (bad) die("keys not strictly increasing"); }
    // own row range: group-aligned boundaries nearest to r*N/P
    std::vector<uint64_t> bnd(P + 1); bnd[0] = 0; bnd[P] = N;
    for (int r = 1; r < P; r++) { uint64_t tgt = N * (uint64_t)r / P; uint64_t g = keys[tgt] >> GB; bnd[r] = gs[g]; }
    const uint64_t lo = bnd[R], hi = bnd[R + 1];
    std::vector<uint32_t> own;   // own nonempty groups
    for (uint64_t g = keys[lo] >> GB; lo < hi && g < NG && gs[g] < hi; g++) if (gs[g + 1] > gs[g]) own.push_back((uint32_t)g);
    fprintf(stderr, "rank %d: rows [%llu, %llu) = %llu states, %zu groups\n", R, (unsigned long long)lo, (unsigned long long)hi,
            (unsigned long long)(hi - lo), own.size());
    // low 2h bits as uint32, compacted in place
    uint32_t *lo32 = (uint32_t *)keys;
    for (uint64_t i = 0; i < N; i++) lo32[i] = (uint32_t)(keys[i] & LOW);     // sequential: safe in place (4i <= 8i)
    uint32_t *lowk = (uint32_t *)realloc(keys, N * 4); if (!lowk) die("realloc");
    // ---- vectors (allocated before the table build so that the level-(h-1) lift can still use the keys)
    const uint64_t NO = hi - lo;
    float *v = (float *)malloc(N * 4); if (!v) die("malloc v");
    std::vector<size_t> boff(P), blen(P);
    for (int r = 0; r < P; r++) { boff[r] = bnd[r] * 4; blen[r] = (bnd[r + 1] - bnd[r]) * 4; }
    char zb[64]; snprintf(zb, sizeof zb, "%.6f", z);
    const std::string vslice = out + "/v_r" + std::to_string(R) + ".f32";
    if (start_it > 0) {
        if (fsize(vslice.c_str()) != NO * 4) die("bad resume slice");
        pread_all(vslice.c_str(), v + lo, NO * 4);
        FILE *fi = fopen((vslice + ".it").c_str(), "r"); int itf = -1; if (!fi || fscanf(fi, "%d", &itf) != 1 || itf != start_it) die("resume iteration mismatch"); fclose(fi);
    } else if (getenv("MH_LIFT_KEYS")) {
        // lift: project each own state to level h-1 (drop the oldest bit of x,y,dx,dy; re-apply the complement reduction)
        size_t kb = fsize(getenv("MH_LIFT_KEYS")); uint64_t Np = kb / 8;
        uint64_t *Kp = (uint64_t *)malloc(kb); double *Vp = (double *)malloc(Np * 8); if (!Kp || !Vp) die("malloc lift");
        pread_all(getenv("MH_LIFT_KEYS"), Kp, kb); if (fsize(getenv("MH_LIFT_V")) != Np * 8) die("bad lift v"); pread_all(getenv("MH_LIFT_V"), Vp, Np * 8);
        double vmin = 1e300; for (uint64_t i = 0; i < Np; i++) vmin = std::min(vmin, Vp[i]);
        const int gg = h - 1; const uint64_t Mg = (1ULL << gg) - 1; uint64_t found = 0;
#pragma omp parallel for schedule(dynamic, 16) reduction(+:found)
        for (size_t gi = 0; gi < own.size(); gi++) {
            uint64_t g = own[gi];
            for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
                uint64_t k = (g << GB) | lowk[i];
                uint64_t x = (k >> (3 * h)) & Mg, y = (k >> (2 * h)) & Mg, dx = (k >> h) & Mg, dy = k & Mg;
                if ((x >> (gg - 1)) & 1) { x ^= Mg; y ^= Mg; }
                uint64_t kp = (x << (3 * gg)) | (y << (2 * gg)) | (dx << gg) | dy;
                const uint64_t *p = std::lower_bound(Kp, Kp + Np, kp);
                v[i] = (p != Kp + Np && *p == kp) ? (float)Vp[p - Kp] : (float)vmin;
                if (p != Kp + Np && *p == kp) found++;
            }
        }
        free(Kp); free(Vp);
        fprintf(stderr, "rank %d: lifted start: %llu of %llu own states found at level %d\n", R, (unsigned long long)found, (unsigned long long)NO, gg);
    } else {
#pragma omp parallel for schedule(static)
        for (uint64_t i = lo; i < hi; i++) v[i] = 1.0f;
    }
    // ---- pass A: masks + per-group stream counts (own rows only)
    std::vector<uint64_t> mask(NO);
    std::vector<uint64_t> c16(own.size() + 1, 0), c32(own.size() + 1, 0);
#pragma omp parallel for schedule(dynamic, 16)
    for (size_t gi = 0; gi < own.size(); gi++) {
        uint64_t g = own[gi], o[64], tg[64]; bool big[64]; uint64_t n16 = 0, n32 = 0;
        for (int t = 0; t < NI; t++) { tg[t] = target_group(h, g, t); big[t] = (gs[tg[t] + 1] - gs[tg[t]]) >= 65536; }
        for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
            fast_delta_all(h, (g << GB) | lowk[i], o); uint64_t m = 0;
            for (int t = 0; t < NI; t++) if (o[t] != ~0ULL) {
                m |= 1ULL << t;
                if ((o[t] >> GB) != tg[t]) die("target group mismatch");
                if (big[t]) n32++; else n16++;
            }
            mask[i - lo] = m;
        }
        c16[gi + 1] = n16; c32[gi + 1] = n32;
    }
    for (size_t gi = 0; gi < own.size(); gi++) { c16[gi + 1] += c16[gi]; c32[gi + 1] += c32[gi]; }
    const uint64_t E16 = c16[own.size()], E32 = c32[own.size()];
    uint16_t *s16 = (uint16_t *)malloc(E16 * 2 + 8); uint32_t *s32 = (uint32_t *)malloc(E32 * 4 + 8);
    if (!s16 || !s32) die("malloc streams");
    uint64_t missing = 0;
#pragma omp parallel for schedule(dynamic, 16) reduction(+:missing)
    for (size_t gi = 0; gi < own.size(); gi++) {
        uint64_t g = own[gi], o[64], tg[64]; bool big[64]; uint64_t p16 = c16[gi], p32 = c32[gi];
        for (int t = 0; t < NI; t++) { tg[t] = target_group(h, g, t); big[t] = (gs[tg[t] + 1] - gs[tg[t]]) >= 65536; }
        for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
            fast_delta_all(h, (g << GB) | lowk[i], o);
            for (int t = 0; t < NI; t++) if (o[t] != ~0ULL) {
                const uint32_t *b = lowk + gs[tg[t]], *e = lowk + gs[tg[t] + 1];
                uint32_t kl = (uint32_t)(o[t] & LOW);
                const uint32_t *p = std::lower_bound(b, e, kl);
                if (p == e || *p != kl) { missing++; continue; }
                uint64_t r = p - b;
                if (big[t]) s32[p32++] = (uint32_t)r; else s16[p16++] = (uint16_t)r;
            }
        }
    }
    if (missing) die("closure failure while building the table");
    fprintf(stderr, "rank %d: table built: %llu uint16 + %llu uint32 entries (%.1f GB) (%.0fs)\n", R, (unsigned long long)E16,
            (unsigned long long)E32, (E16 * 2.0 + E32 * 4.0) * 1e-9, now() - t0);
    free(lowk);
    double *vn = (double *)malloc(NO * 8); if (!vn) die("malloc vn");
    ring.setup(ips, port);
    ring.allgather((char *)v, boff, blen);
    // weights by repeated multiplication (IEEE, fixed order)
    double w[64], zp[64]; zp[0] = 1.0; for (int k = 1; k <= h + 1; k++) zp[k] = zp[k - 1] * z;
    for (int t = 0; t < NI; t++) { int l = (t % L) - (h - 1), al = abs(l); w[t] = (al < h - 1) ? zp[al + 2] : zp[h + 1] / (1.0 - z); }
    double te = now();
    for (int it = start_it + 1; it <= iters; it++) {
        double mx = 0, rmin = 1e300, rmax = 0;
#pragma omp parallel for schedule(dynamic, 16) reduction(max:mx, rmax) reduction(min:rmin)
        for (size_t gi = 0; gi < own.size(); gi++) {
            uint64_t g = own[gi], p16 = c16[gi], p32 = c32[gi], base[64]; bool big[64];
            for (int t = 0; t < NI; t++) { uint64_t tg = target_group(h, g, t); base[t] = gs[tg]; big[t] = (gs[tg + 1] - gs[tg]) >= 65536; }
            for (uint64_t i = gs[g]; i < gs[g + 1]; i++) {
                uint64_t m = mask[i - lo]; double s = 0;
                while (m) {
                    int t = __builtin_ctzll(m); m &= m - 1;
                    uint64_t r = big[t] ? s32[p32++] : s16[p16++];
                    s += w[t] * (double)v[base[t] + r];
                }
                vn[i - lo] = s; double rr = s / (double)v[i];
                if (s > mx) mx = s; if (rr > rmax) rmax = rr; if (rr < rmin) rmin = rr;
            }
        }
        double mine[3] = {mx, -rmin, rmax}, all[3 * 64];
        ring.allgather_small(mine, sizeof mine, all);
        double gmx = 0, grmin = 1e300, grmax = 0;
        for (int r = 0; r < P; r++) { gmx = std::max(gmx, all[3 * r]); grmin = std::min(grmin, -all[3 * r + 1]); grmax = std::max(grmax, all[3 * r + 2]); }
        const double inv = 1.0 / gmx;
#pragma omp parallel for schedule(static)
        for (uint64_t i = lo; i < hi; i++) v[i] = (float)(vn[i - lo] * inv);
        ring.allgather((char *)v, boff, blen);
        if (R == 0) fprintf(stderr, "  z=%s it %d: ratio in [%.15f, %.15f] gap %.3e bound(rmax)=%.9f (%.0fs)\n", zb, it, grmin, grmax,
                            grmax / grmin - 1, 2 * log(2 * z) / log(grmax), now() - te);
        int stop_all = 0; { int sm = g_stop ? 1 : 0, sa[64]; ring.allgather_small(&sm, sizeof sm, sa); for (int r = 0; r < P; r++) stop_all |= sa[r]; }
        if (it % ckpt == 0 || it == iters || stop_all) {
            write_atomic(vslice, v + lo, NO * 4);
            FILE *fi = fopen((vslice + ".it").c_str(), "w"); if (fi) { fprintf(fi, "%d\n", it); fclose(fi); }
        }
        if (stop_all) { fprintf(stderr, "rank %d: stopped after iteration %d (checkpointed)\n", R, it); return 3; }
    }
    write_atomic(out + "/h" + std::to_string(h) + "_v_" + zb + ".r" + std::to_string(R) + ".f32", v, N * 4);   // identical on every rank
    fprintf(stderr, "rank %d: done, full float32 vector written (%.0fs)\n", R, now() - t0);
    printf("rank %d rows [%llu, %llu) done after %d iterations\n", R, (unsigned long long)lo, (unsigned long long)hi, iters);
    return 0;
}
