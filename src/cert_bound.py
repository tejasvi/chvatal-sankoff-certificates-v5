#!/usr/bin/env python3
"""Final bound from a checked certificate: gamma_2 <= 2 ln(2z) / ln(lam), lam = LAM_NUM / 2^64, z exact decimal.

usage: cert_bound.py Z_DECIMAL LAM_NUM
Evaluates with mpmath interval arithmetic at 80 digits and prints the upper end rounded UP to 6 decimals.
"""
import sys
from fractions import Fraction
import mpmath
from mpmath import iv

z = Fraction(sys.argv[1]); lam_num = int(sys.argv[2])
lam = Fraction(lam_num, 2 ** 64)
assert 0 < z < Fraction(1, 2) and 0 < lam < 1
iv.dps = 80
zi = iv.mpf(z.numerator) / z.denominator
li = iv.mpf(lam_num) / iv.mpf(2) ** 64
beta = 2 * iv.log(2 * zi) / iv.log(li)
mpmath.mp.dps = 80
hi = mpmath.mpf(beta.b)                      # rigorous upper endpoint (binary float)
man, exp = hi.man, hi.exp                    # hi = man * 2^exp exactly
hiF = Fraction(int(man)) * (Fraction(2) ** exp)
k = -((-hiF * 10 ** 6).numerator // (hiF * 10 ** 6).denominator)   # exact ceil
assert Fraction(k, 10 ** 6) >= hiF and Fraction(k - 1, 10 ** 6) < hiF
print('z = %s, lam = %d/2^64 = %s' % (sys.argv[1], lam_num, mpmath.nstr(mpmath.mpf(lam_num) / 2 ** 64, 20)))
print('bound interval = [%s, %s]' % (mpmath.nstr(mpmath.mpf(beta.a.a), 25), mpmath.nstr(mpmath.mpf(beta.b.b), 25)))
print('CERTIFIED: gamma_2 <= %d.%06d' % (k // 10 ** 6, k % 10 ** 6))
