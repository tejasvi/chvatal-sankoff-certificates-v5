#!/usr/bin/env python3
"""Audit reference for Lueker's automaton M_h (Chvatal-Sankoff upper bound), written for the audit from the definition
(Lueker's code overview code.pdf and DPTable/State semantics; the definitions in the paper), not from the first
checker's code.

State q = (x, y, dx, dy): four h-bit integers, most significant bit = oldest symbol / first difference.
delta(q, c, l), c in {0,1}, -(h-1) <= l <= h-1  (input T_{c,l}: (cbar^l c, c) for l >= 0, (c, cbar^|l| c) for l < 0):
  window a[1..h] = x, b[1..h] = y; W[h][h] = 0; W[r][h] - W[r-1][h] = dx bit r (r = 1..h); W[h][s] - W[h][s-1] = dy bit s;
  append the pair; extend row 0 and column 0 by constants beyond h; fill cells with r > h or s > h by the LCS recurrence;
  canonical backtrack (up if equal, else left if equal, else diagonal) from (aLen, bLen) while r >= h and s >= h;
  accept iff it reaches (h, h); new state = last h symbols of a, b, last h vertical differences of column bLen and last h
  horizontal differences of row aLen; reduce: if the top bit of x is 1, complement x and y.
Also: canonical decomposition of a string pair into minimal match pairs, and a random covering test (Lueker's Test idea:
feeding the truncated pairs from the start state never rejects; run with reduction off).
Usage: python -I mh_audit_ref.py table2 | count HMAX | cover H NTRIALS NLEN"""
import sys, random
from collections import deque

if not __debug__:
    raise SystemExit("this program relies on assert statements; run it without -O")


def delta(h, q, c, l, reduce=True, check=True):
    x, y, dx, dy = q
    n = 2 * h + 1
    a = [None] * (n + 1); b = [None] * (n + 1)
    for r in range(1, h + 1):
        a[r] = (x >> (h - r)) & 1
        b[r] = (y >> (h - r)) & 1
    W = {}
    W[(h, h)] = 0
    for r in range(h, 0, -1):
        W[(r - 1, h)] = W[(r, h)] - ((dx >> (h - r)) & 1)
    for s in range(h, 0, -1):
        W[(h, s - 1)] = W[(h, s)] - ((dy >> (h - s)) & 1)
    aLen = bLen = h
    if l > 0:
        for _ in range(l):
            aLen += 1; a[aLen] = 1 - c
    elif l < 0:
        for _ in range(-l):
            bLen += 1; b[bLen] = 1 - c
    aLen += 1; a[aLen] = c
    bLen += 1; b[bLen] = c
    for s in range(h + 1, bLen + 1):
        W[(0, s)] = W[(0, s - 1)]
    for r in range(h + 1, aLen + 1):
        W[(r, 0)] = W[(r - 1, 0)]
    for r in range(1, aLen + 1):
        for s in range(1, bLen + 1):
            if r > h or s > h:
                if a[r] == b[s]:
                    W[(r, s)] = W[(r - 1, s - 1)] + 1
                else:
                    W[(r, s)] = max(W[(r - 1, s)], W[(r, s - 1)])
                if check:
                    assert W[(r, s)] - W[(r - 1, s)] in (0, 1) and W[(r, s)] - W[(r, s - 1)] in (0, 1)
    r, s, matches = aLen, bLen, 0
    accepted = False
    while r >= h and s >= h:
        if r == h and s == h:
            accepted = True
            break
        if W[(r, s)] == W[(r - 1, s)]:
            r -= 1
        elif W[(r, s)] == W[(r, s - 1)]:
            s -= 1
        else:
            assert W[(r, s)] == W[(r - 1, s - 1)] + 1 and a[r] == b[s]
            r -= 1; s -= 1; matches += 1
    if not accepted:
        return None
    assert matches == 1
    nx = 0; ny = 0; ndx = 0; ndy = 0
    for i in range(aLen - h + 1, aLen + 1):
        nx = (nx << 1) | a[i]
        ndx = (ndx << 1) | (W[(i, bLen)] - W[(i - 1, bLen)])
    for j in range(bLen - h + 1, bLen + 1):
        ny = (ny << 1) | b[j]
        ndy = (ndy << 1) | (W[(aLen, j)] - W[(aLen, j - 1)])
    if reduce and (nx >> (h - 1)) & 1:
        m = (1 << h) - 1
        nx ^= m; ny ^= m
    return (nx, ny, ndx, ndy)


def start(h):
    m = (1 << h) - 1
    return (0, 0, m, m)


def bfs(h):
    q0 = start(h)
    num = {q0: 1}; order = [q0]; dq = deque([q0]); rows = []
    while dq:
        q = dq.popleft()
        row = {}
        for c in (0, 1):
            for l in range(-(h - 1), h):
                t = delta(h, q, c, l)
                if t is not None:
                    if t not in num:
                        num[t] = len(order) + 1; order.append(t); dq.append(t)
                    row[(c, l)] = num[t]
                else:
                    row[(c, l)] = 0
        rows.append(row)
    return order, rows


def canonical_decomposition(A, B):
    n, m = len(A), len(B)
    L = [[0] * (m + 1) for _ in range(n + 1)]
    for i in range(1, n + 1):
        for j in range(1, m + 1):
            L[i][j] = L[i - 1][j - 1] + 1 if A[i - 1] == B[j - 1] else max(L[i - 1][j], L[i][j - 1])
    i, j, diag = n, m, []
    while i > 0 and j > 0:
        if L[i - 1][j] == L[i][j]:
            i -= 1
        elif L[i][j - 1] == L[i][j]:
            j -= 1
        else:
            diag.append((i, j)); i -= 1; j -= 1
    diag.reverse()
    pairs = []
    pi, pj = 0, 0
    for (i, j) in diag:
        u, v = A[pi:i], B[pj:j]
        # minimal match pair check
        assert u[-1] == v[-1]
        for ii in range(len(u)):
            for jj in range(len(v)):
                if (ii, jj) != (len(u) - 1, len(v) - 1):
                    assert u[ii] != v[jj]
        assert len(u) == 1 or len(v) == 1
        c = u[-1]
        l = len(u) - 1 if len(v) == 1 else -(len(v) - 1)
        pairs.append((c, l))
        pi, pj = i, j
    tail = (A[pi:], B[pj:])
    assert not any(x == y for x in tail[0] for y in tail[1])
    return pairs, L[n][m]


if __name__ == "__main__":
    mode = sys.argv[1]
    if mode == "table2":
        order, rows = bfs(2)
        print("h=2 states:", len(order))
        for k, (q, row) in enumerate(zip(order, rows), 1):
            fmt = lambda v: format(v, "02b")
            cells = [f"q{row[(c, l)]}" for c in (0, 1) for l in (-1, 0, 1)]
            print(f"q{k} = <{fmt(q[0])},{fmt(q[1])},{fmt(q[2])},{fmt(q[3])}>  " + " ".join(cells))
    elif mode == "count":
        for h in range(2, int(sys.argv[2]) + 1):
            order, rows = bfs(h)
            acc = sum(1 for row in rows for v in row.values() if v)
            print(f"h={h}: states {len(order)}, accepted transitions {acc}", flush=True)
    elif mode in ("cover", "coverruns"):
        h, trials, nlen = int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4])
        random.seed(20261020 + h + (1000 if mode == "coverruns" else 0))
        rejects = 0; npairs = 0; ntrunc = 0

        def rnd():
            if mode == "cover":
                return [random.randint(0, 1) for _ in range(nlen)]
            p = random.choice((0.05, 0.1, 0.2, 0.5))     # Markov switching probability: long runs exercise mu
            s = [random.randint(0, 1)]
            while len(s) < nlen:
                s.append(1 - s[-1] if random.random() < p else s[-1])
            return s
        for t in range(trials):
            A = rnd(); B = rnd()
            pairs, L = canonical_decomposition(A, B)
            assert len(pairs) == L
            q = start(h)
            for (c, l) in pairs:
                lt = max(-(h - 1), min(h - 1, l))
                ntrunc += lt != l
                q = delta(h, q, c, lt, reduce=False)
                npairs += 1
                if q is None:
                    rejects += 1; break
        print(f"{mode} test h={h}: {trials} random pairs of length {nlen}, {npairs} pairs fed ({ntrunc} truncated), "
              f"rejections: {rejects}")
