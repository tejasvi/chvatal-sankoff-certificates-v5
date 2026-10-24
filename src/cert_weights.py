#!/usr/bin/env python3
"""Exact upward-rounded weights for the checker.

usage: cert_weights.py H Z_DECIMAL OUTFILE
  z is the exact rational given by the decimal string (e.g. 0.3376 = 211/625), 0 < z < 1/2.
  Writes Wt[k] = ceil(2^64 * w_z(k)), k = 0..H-1, where w_z(k) = z^(k+2) for k < H-1 and z^(H+1)/(1-z) for k = H-1
  (the total weight of all minimal match pairs T_{c,l} with mu-image of padding |l| = k, for one fixed c).
"""
import sys
from fractions import Fraction

h = int(sys.argv[1]); z = Fraction(sys.argv[2]); out = sys.argv[3]
assert 0 < z < Fraction(1, 2)
W = []
for k in range(h):
    w = z ** (k + 2) if k < h - 1 else z ** (h + 1) / (1 - z)
    t = w * 2 ** 64
    c = -((-t.numerator) // t.denominator)      # ceil
    assert c >= t and c - 1 < t and 0 < c < 2 ** 64
    W.append(c)
with open(out, 'w') as f:
    f.write('\n'.join(str(c) for c in W) + '\n')
print('z = %s = %s; weights written to %s' % (sys.argv[2], z, out))
