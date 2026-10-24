# Exact-rational re-check (Fractions only) of a certificate for small h, using mh_ref.delta (Python reference transitions)
# usage: pycheck.py H KEYS VEC Z
import sys, struct, math
from fractions import Fraction
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(sys.argv[0]))), 'src'))
from mh_ref import delta
h = int(sys.argv[1]); z = Fraction(sys.argv[4])
keys = list(struct.unpack('<%dQ' % (len(open(sys.argv[2], 'rb').read()) // 8), open(sys.argv[2], 'rb').read()))
vals = list(struct.unpack('<%dd' % len(keys), open(sys.argv[3], 'rb').read()))
idx = {k: i for i, k in enumerate(keys)}
M = (1 << h) - 1
def bits(v): return tuple((v >> (h - 1 - i)) & 1 for i in range(h))
def unbits(t):
    v = 0
    for b in t: v = 2 * v + b
    return v
w = {k: (z ** (k + 2) if k < h - 1 else z ** (h + 1) / (1 - z)) for k in range(h)}
lam = Fraction(0)
for i, k in enumerate(keys):
    q = (bits(k >> (3 * h) & M), bits(k >> (2 * h) & M), bits(k >> h & M), bits(k & M))
    s = Fraction(0)
    for c in (0, 1):
        for l in range(-(h - 1), h):
            t = delta(q, c, l, h)
            if t is None: continue
            kk = (unbits(t[0]) << (3 * h)) | (unbits(t[1]) << (2 * h)) | (unbits(t[2]) << h) | unbits(t[3])
            s += w[abs(l)] * Fraction(vals[idx[kk]])
    lam = max(lam, s / Fraction(vals[i]))
print('exact max ratio =', float(lam), ' 2^64*lam =', math.ceil(lam * 2 ** 64))
