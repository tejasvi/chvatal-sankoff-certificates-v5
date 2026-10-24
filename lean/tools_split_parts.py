#!/usr/bin/env python3
"""Cut a certificate (keys file, vector file) into the part files of a generated K module tree (parts.tsv from
tools_gen_kl.py): part i = entries [first, first + count) of both files, written to OUTDIR/k<i>.bin, v<i>.bin.
usage: tools_split_parts.py KEYS VEC PARTS_TSV OUTDIR"""
import os, sys
keys, vec, parts, out = sys.argv[1:5]
os.makedirs(out, exist_ok=True)
with open(keys, 'rb') as fk, open(vec, 'rb') as fv:
    for line in open(parts):
        i, first, count = (int(x) for x in line.split())
        for src, pre in ((fk, 'k'), (fv, 'v')):
            src.seek(8 * first)
            data = src.read(8 * count)
            assert len(data) == 8 * count, (i, pre)
            with open(os.path.join(out, f'{pre}{i}.bin'), 'wb') as g:
                g.write(data)
print('parts written:', sum(1 for _ in open(parts)))
