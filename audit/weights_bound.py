#!/usr/bin/env python3
"""Helper of the second checker (independent of the first checker's scripts).
weights H ZDEC      -> W_k = ceil(2^64 w_z(k)), k = 0..H-1, from the exact rational z = ZDEC (decimal string):
                       w_z(k) = z^(k+2) for k < H-1,  z^(H+1)/(1-z) for k = H-1  (Lueker's truncation weights).
bound ZDEC LAM      -> 2 ln(2z)/ln(LAM/2^64) with outward-rounded interval arithmetic (mpmath iv, 200 bits) and an
                       exact rational upward rounding to 6 decimals (python-flint arb used as a second evaluation)."""
import sys
from fractions import Fraction
from math import ceil

if not __debug__:
    raise SystemExit("this program relies on assert statements; run it without -O")


def weights(h, zdec):
    z = Fraction(zdec)
    assert 0 < z < Fraction(1, 2)
    out = []
    for k in range(h):
        w = z ** (k + 2) if k < h - 1 else z ** (h + 1) / (1 - z)
        W = -((-w * 2 ** 64) // 1)            # ceil
        assert Fraction(W, 2 ** 64) >= w and Fraction(W - 1, 2 ** 64) < w
        out.append(int(W))
    return out


def bound(zdec, lam):
    from mpmath import iv, mp
    import flint
    z = Fraction(zdec); L = Fraction(int(lam), 2 ** 64)
    assert 0 < L < 1 and 0 < 2 * z < 1
    iv.prec = 200
    zi = iv.mpf(z.numerator) / z.denominator
    li = iv.mpf(L.numerator) / L.denominator
    B = 2 * iv.log(2 * zi) / iv.log(li)
    hi = Fraction(int(mp.mpf(B.b).man) * (2 ** int(mp.mpf(B.b).exp)) if mp.mpf(B.b).exp >= 0 else
                  Fraction(int(mp.mpf(B.b).man), 2 ** (-int(mp.mpf(B.b).exp))))
    up6 = Fraction(-((-hi * 10 ** 6) // 1), 10 ** 6)
    flint.ctx.prec = 200
    za = flint.arb(flint.fmpq(z.numerator, z.denominator)); la = flint.arb(flint.fmpq(L.numerator, L.denominator))
    Ba = 2 * (2 * za).log() / la.log()
    return B, up6, Ba


if __name__ == "__main__":
    if sys.argv[1] == "weights":
        print(",".join(str(w) for w in weights(int(sys.argv[2]), sys.argv[3])))
    else:
        B, up6, Ba = bound(sys.argv[2], sys.argv[3])
        print(f"interval (mpmath iv): [{B.a}, {B.b}]")
        print(f"arb: {Ba}")
        print(f"bound rounded up to 6 decimals: gamma_2 <= {float(up6):.6f}  (exact {up6})")
