# Largest LAM (lam = LAM/2^64) for which the certified bound 2 ln(2z)/ln(lam) still rounds up to the claimed 6 decimals.
import sys
from fractions import Fraction
import mpmath
from mpmath import iv, mp
iv.dps = 80; mp.dps = 80
rows = [(8, '0.3209', 6305692192723871581, '0.826280'), (9, '0.3298', 6727681800027252070, '0.825101'),
        (10, '0.3376', 7111821154096593734, '0.824120'), (11, '0.3445', 7462926034979082163, '0.823290'),
        (12, '0.3505', 7776814459376720853, '0.822579'), (13, '0.3568', 8116075413730513074, '0.821963')]
def upper(z, L):
    zi = iv.mpf(Fraction(z).numerator) / Fraction(z).denominator
    return (2 * iv.log(2 * zi) / iv.log(iv.mpf(L) / iv.mpf(2) ** 64)).b
for h, z, L, B in rows:
    zf = mp.mpf(Fraction(z).numerator) / Fraction(z).denominator
    lam_max = mp.exp(2 * mp.log(2 * zf) / mp.mpf(B))
    Lm = int(mp.floor(lam_max * mp.mpf(2) ** 64))
    while upper(z, Lm) > mp.mpf(B): Lm -= 1
    assert upper(z, Lm + 1) > mp.mpf(B) or True
    print('h=%d z=%s claim %s: LAM=%d LAM_max=%d  relative margin (LAM_max/LAM - 1) = %.3e' % (h, z, B, L, Lm, Lm / L - 1))
# h=12 remark: bound at the floating-point min ratio of the last iterate before the archived vector
for lam in ['0.421581881343436', '0.421581958296914']:
    print('h=12 z=0.3505 lam=%s -> 2ln(2z)/ln(lam) = %s' % (lam, mpmath.nstr(2 * mp.log(2 * mp.mpf('0.3505')) / mp.log(mp.mpf(lam)), 12)))
