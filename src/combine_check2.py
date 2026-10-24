#!/usr/bin/env python3
"""Combine the outputs of split check2 runs (--rows LO HI, optionally --segments S).

usage: python3 -I combine_check2.py OUT1 [OUT2 ...]

Pieces taken from the stdout files:
  * final partial lines   "h=H rows=LO-HI total_states=N ... lam_num=X ... keys_fp=F v_fp=G w_fp=W"
    (only if the same file has no "FAIL" line),
  * SEGMENT lines         "SEGMENT h=H rows=LO-HI total_states=N ... closure_failures=0 lam_num=X keys_fp=F ..." (a run that
    was cut off still certifies its finished segments; check2 prints them only after the global checks passed),
  * full-run lines        "h=H states=N accepted_transitions=A lam_num=X ..." (cover [0,N); no fingerprints).
Requires: one h, one N, one (keys_fp, v_fp, w_fp) triple, and pieces whose union is exactly [0,N) (overlaps allowed).
Prints LAM = max lam_num over the pieces used and the total accepted transitions of a non-overlapping tiling.
"""
import re
import sys

pieces = []        # (lo, hi, lam, acc, h, N, fp, src)
bad = []
for path in sys.argv[1:]:
    text = open(path).read()
    failed = any(l.startswith('FAIL') for l in text.splitlines())
    finals, segs = [], []
    for line in text.splitlines():
        kv = dict(re.findall(r'(\w+)=([0-9a-fA-F.\-:]+)', line))
        if line.startswith('SEGMENT '):
            if kv.get('closure_failures') != '0':
                bad.append('%s: segment %s has closure failures' % (path, kv.get('rows')))
                continue
            lo, hi = map(int, kv['rows'].split('-'))
            segs.append((lo, hi, int(kv['lam_num']), int(kv['accepted_transitions']), int(kv['h']),
                         int(kv['total_states']), (kv['keys_fp'], kv['v_fp'], kv['w_fp']), path + ' (segment)'))
        elif line.startswith('h=') and 'rows=' in line and 'total_states=' in line:
            lo, hi = map(int, kv['rows'].split('-'))
            finals.append((lo, hi, int(kv['lam_num']), int(kv['accepted_transitions']), int(kv['h']),
                           int(kv['total_states']), (kv['keys_fp'], kv['v_fp'], kv['w_fp']), path))
        elif line.startswith('h=') and 'states=' in line and 'rows=' not in line:
            N = int(kv['states'])
            finals.append((0, N, int(kv['lam_num']), int(kv['accepted_transitions']), int(kv['h']), N, None, path))
    if failed:
        bad.append('%s: contains FAIL (final line ignored; SEGMENT lines with closure_failures=0 kept)' % path)
    if finals and not failed:
        pieces.extend(finals)            # the final line covers the file's segments
    else:
        pieces.extend(segs)

if not pieces:
    sys.exit('no usable pieces; problems: %s' % bad)
hs = {p[4] for p in pieces}
Ns = {p[5] for p in pieces if p[5] is not None}
fps = {p[6] for p in pieces if p[6] is not None}
ok = True
if len(hs) != 1:
    print('ERROR: different h values', hs); ok = False
if len(Ns) != 1:
    print('ERROR: total_states missing or inconsistent', Ns); ok = False
if len(fps) > 1:
    print('ERROR: different input fingerprints', fps); ok = False
N = Ns.pop() if len(Ns) == 1 else None
# coverage of [0,N)
iv = sorted((p[0], p[1]) for p in pieces)
cur = 0
for lo, hi in iv:
    if lo > cur:
        print('ERROR: rows %d-%d not covered' % (cur, lo)); ok = False
    cur = max(cur, hi)
if N is not None and cur < N:
    print('ERROR: rows %d-%d not covered' % (cur, N)); ok = False
if N is not None and cur > N:
    print('ERROR: rows beyond N'); ok = False
LAM = max(p[2] for p in pieces)
# accepted transitions over a non-overlapping tiling (only if the pieces do not overlap)
tot = sum(p[1] - p[0] for p in pieces)
acc = sum(p[3] for p in pieces) if N is not None and tot == N else None
for b in bad:
    print('note:', b)
for p in sorted(pieces):
    print('piece rows=%d-%d lam_num=%d accepted=%d  [%s]' % (p[0], p[1], p[2], p[3], p[7]))
print('h=%s N=%s fingerprints=%s' % (hs, N, fps))
print('accepted_transitions(total)=%s' % acc)
print('LAM=%d lam=%.17g' % (LAM, LAM / 2.0 ** 64))
print('RESULT: %s' % ('OK (A_z v <= LAM/2^64 v on all rows, given rc=0 runs on identical inputs)' if ok else 'NOT COMBINABLE'))
sys.exit(0 if ok else 1)
