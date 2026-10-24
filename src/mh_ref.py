#!/usr/bin/env python3
"""Reference (slow, literal) implementation of Lueker's automaton M_h, written from the definition in
Section 3 of the paper (not from any downloaded code).

State q = (x, y, dx, dy): tuples of h bits, oldest first.
  x  = last h symbols of the top string, y = last h symbols of the bottom string,
  dx = increments W(r,h)-W(r-1,h), r = 1..h (down the last column),
  dy = increments W(h,s)-W(h,s-1), s = 1..h (along the last row).
Input T_{c,l}: l >= 0: top cbar^l c, bottom c;  l < 0: top c, bottom cbar^|l| c.  |l| <= h-1.

usage: mh_ref.py bfs H            BFS from the start state; prints state count (and the table for small H)
       mh_ref.py lam H z          lambda(z) by dense/sparse eigen-solver, and the bound 2 ln(2z)/ln(lambda)
"""
import sys
from collections import deque

def delta(q, c, l, h, reduce=True):
    x, y, dx, dy = q
    a = [None] + list(x)          # a[1..h]
    b = [None] + list(y)
    if l >= 0:
        a += [1 - c] * l + [c]; b += [c]
    else:
        a += [c]; b += [1 - c] * (-l) + [c]
    aL, bL = len(a) - 1, len(b) - 1
    W = {}
    W[(h, h)] = 0
    for r in range(h, 0, -1):
        W[(r - 1, h)] = W[(r, h)] - dx[r - 1]
    for s in range(h, 0, -1):
        W[(h, s - 1)] = W[(h, s)] - dy[s - 1]
    for s in range(h + 1, bL + 1):
        W[(0, s)] = W[(0, h)]
    for r in range(h + 1, aL + 1):
        W[(r, 0)] = W[(h, 0)]
    for r in range(1, aL + 1):
        for s in range(1, bL + 1):
            if r > h or s > h:
                if a[r] == b[s]:
                    W[(r, s)] = W[(r - 1, s - 1)] + 1
                else:
                    W[(r, s)] = max(W[(r - 1, s)], W[(r, s - 1)])
    # sanity: increments in {0,1} on the filled region
    for (r, s), v in W.items():
        if r > h or s > h:
            if r >= 1 and (r - 1, s) in W: assert W[(r, s)] - W[(r - 1, s)] in (0, 1)
            if s >= 1 and (r, s - 1) in W: assert W[(r, s)] - W[(r, s - 1)] in (0, 1)
    # canonical backtrack
    r, s = aL, bL
    ok = False
    while r >= h and s >= h:
        if W[(r - 1, s)] == W[(r, s)]:
            r -= 1
        elif W[(r, s - 1)] == W[(r, s)]:
            s -= 1
        else:
            r -= 1; s -= 1
        if r == h and s == h:
            ok = True
            break
    if not ok:
        return None
    nx = tuple(a[aL - h + 1: aL + 1])
    ny = tuple(b[bL - h + 1: bL + 1])
    ndx = tuple(W[(r, bL)] - W[(r - 1, bL)] for r in range(aL - h + 1, aL + 1))
    ndy = tuple(W[(aL, s)] - W[(aL, s - 1)] for s in range(bL - h + 1, bL + 1))
    if reduce and nx[0] == 1:
        nx = tuple(1 - t for t in nx); ny = tuple(1 - t for t in ny)
    return (nx, ny, ndx, ndy)

def start(h):
    return ((0,) * h, (0,) * h, (1,) * h, (1,) * h)

def bfs(h, reduce=True):
    q0 = start(h)
    idx = {q0: 1}
    order = [q0]
    rows = []
    dq = deque([q0])
    while dq:
        q = dq.popleft()
        row = {}
        for c in (0, 1):
            for l in range(-(h - 1), h):
                t = delta(q, c, l, h, reduce)
                if t is None:
                    row[(c, l)] = 0
                else:
                    if t not in idx:
                        idx[t] = len(order) + 1; order.append(t); dq.append(t)
                    row[(c, l)] = idx[t]
        rows.append(row)
    return order, rows, idx

def bits2int(t):
    v = 0
    for u in t: v = 2 * v + u
    return v

def weights(h, z):
    w = {}
    for l in range(-(h - 1), h):
        w[l] = z ** (abs(l) + 2) if abs(l) < h - 1 else z ** (h + 1) / (1 - z)
    return w

if __name__ == '__main__':
    cmd, h = sys.argv[1], int(sys.argv[2])
    if cmd == 'bfs':
        order, rows, idx = bfs(h)
        print('h=%d states=%d accepted_transitions=%d' % (h, len(order), sum(1 for r in rows for v in r.values() if v)))
        if h <= 2:
            for i, (q, row) in enumerate(zip(order, rows), 1):
                print('q%d = <%s,%s,%s,%s>' % (i, *(''.join(map(str, t)) for t in q)),
                      ' '.join('q%d' % row[(c, l)] for c in (0, 1) for l in range(-(h - 1), h)))
    elif cmd == 'lam':
        import numpy as np
        z = float(sys.argv[3])
        order, rows, idx = bfs(h)
        n = len(order); w = weights(h, z)
        A = np.zeros((n, n))
        for i, row in enumerate(rows):
            for (c, l), j in row.items():
                if j: A[i, j - 1] += w[l]
        ev = np.linalg.eigvals(A)
        lam = max(abs(ev))
        import math
        print('h=%d z=%g states=%d lambda=%.15f bound=%.9f' % (h, z, n, lam, 2 * math.log(2 * z) / math.log(lam)))
