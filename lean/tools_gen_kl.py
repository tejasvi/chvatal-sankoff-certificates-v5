#!/usr/bin/env python3
"""Generate the kernel-only (K) modules for M_h with the lane-packed checker checkKL (CS31aCert/KLane.lean):
  CS31aK/<name>/D<i>.lean      (DD > 0) sub-data module i < 2^DD: the KTree of the node range i at depth DD of the
                               balanced tree (ktree_of_files% on the part files <PARTDIR>/k<i>.bin, v<i>.bin)
  CS31aK/<name>/Data.lean      the whole KTree (DD = 0: one literal from KEYS/VEC; DD > 0: the top DD levels as a
                               literal over the D<i>.tree constants, split keys = first keys of the right parts),
                               weights, Lambda
  CS31aK/<name>/S<m>.lean      B shard theorems s<i> : checkKL h tree wt lam (tree.sub path_i) = true (decide +kernel),
                               path_i = the D = D1 + D2 bits of i (most significant first), i = m B .. m B + B - 1
  CS31aK/<name>/G<g>.lean      group g: checkKL on tree.sub (first D1 bits of g), from its 2^D2 shards by checkKL_split
  CS31aK/<name>.lean           global check (findL), the whole tree from the 2^D1 groups, final theorems
  CS31aK/<name>/parts.tsv      (DD > 0) part i, first entry, entry count (byte ranges of the part files: 8 x entries)
The tree shape is that of ktree_of_files% on the whole files (mkKTree in CS31aData/KElab.lean): a node range [lo, hi)
with c = ceil((hi - lo) / CHUNK) leaves splits at lo + (c // 2) CHUNK, so a node range at depth DD built from its own
part file is the same subtree. With DD > 0 the split keys are read from the part files (first 8 bytes of a part).
usage: tools_gen_kl.py H KEYS VEC N CHUNK DD PARTDIR D1 D2 B LAM ZN ZD P Q BOUND W0,W1,...
       (module name H<h>, or $KNAME;
       PHASE=parts writes only parts.tsv, so that the part files can be cut before the full run reads their first keys;
       FIRSTKEYS=<file of "i key" lines> supplies the first keys of the parts instead of the part files;
       DNAMES=<file of "i suffix" lines>: sub-data module i is named D<i><suffix> (suffixes chosen so that the
       oleans' mmap base addresses do not collide; gen/dnames_h11.txt lists those of the h = 11 package);
       MODE=split: each shard module proves its whole subtree with one theorem mod<m> by `kl_split log2(B)` (each of its
       B shards is checked in its own auxiliary lemma), groups combine the module theorems; shard modules then import
       only CS31a.KLSplit (core Lean))
"""
import os, sys, shutil
(h, keys, vec, n, chunk, dd, partdir, d1, d2, bsz, lam, zn, zd, p, q, bound, wts) = sys.argv[1:18]
h = int(h); n = int(n); chunk = int(chunk); dd = int(dd); d1 = int(d1); d2 = int(d2); bsz = int(bsz)
D = d1 + d2
assert (2 ** d2) % bsz == 0 and 1 <= h <= 16
wt = [int(x) for x in wts.split(',')]
split_mode = os.environ.get('MODE') == 'split'   # one theorem per module, proved by kl_split (CS31a/KLSplit.lean)
pre = ''
soundmod = 'CS31a.KLaneSound'
root = os.path.dirname(os.path.abspath(__file__))
name = os.environ.get('KNAME', f'H{h}')
DIR = os.path.join(root, 'CS31aK', name)
if os.path.isdir(DIR): shutil.rmtree(DIR)
os.makedirs(DIR)
def bits(v, d): return [bool((v >> (d - 1 - j)) & 1) for j in range(d)]
def lit(bs): return '[' + ', '.join('true' if b else 'false' for b in bs) + ']'
def split(lo, hi):
    c = (hi - lo + chunk - 1) // chunk
    return lo + (c // 2) * chunk
header = f'''namespace CS31aK.{name}

open CS31aCert
'''
footer = f'''def wt : List Nat := {wt}

def lam : Nat := {lam}

end CS31aK.{name}
'''
if dd == 0:
    with open(os.path.join(DIR, 'Data.lean'), 'w') as f:
        f.write(f'''import CS31aData.KElab

/-! K data, h = {h}: {os.path.basename(keys)} / {os.path.basename(vec)} ({n} entries), leaves of {chunk} entries. -/

{header}
set_option maxRecDepth 1000000 in
set_option maxHeartbeats 0 in
noncomputable def tree : KTree := ktree_of_files% "{keys}" "{vec}" {n} {chunk}

{footer}''')
else:
    ranges = [(0, n)]
    for _ in range(dd):
        nxt = []
        for lo, hi in ranges:
            assert hi - lo > chunk, 'DD too deep for N'
            mid = split(lo, hi)
            nxt += [(lo, mid), (mid, hi)]
        ranges = nxt
    dsuf = {}
    if os.environ.get('DNAMES'):
        for line in open(os.environ['DNAMES']):
            w = line.split()
            if len(w) >= 2 and not w[1].startswith(('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')): dsuf[int(w[0])] = w[1]
    dn = lambda i: f'D{i}{dsuf.get(i, "")}'
    with open(os.path.join(DIR, 'parts.tsv'), 'w') as f:
        for i, (lo, hi) in enumerate(ranges):
            f.write(f'{i}\t{lo}\t{hi - lo}\n')
    if os.environ.get('PHASE') == 'parts':
        print('parts.tsv written:', len(ranges), 'parts'); sys.exit(0)
    for i, (lo, hi) in enumerate(ranges):
        with open(os.path.join(DIR, f'{dn(i)}.lean'), 'w') as f:
            f.write(f'''import CS31aData.KElab

/-! K sub-data {i}, h = {h}: entries {lo} .. {hi - 1} of {os.path.basename(keys)} / {os.path.basename(vec)}
(part files k{i}.bin / v{i}.bin), leaves of {chunk} entries. -/

namespace CS31aK.{name}.{dn(i)}

open CS31aCert

set_option maxRecDepth 1000000 in
set_option maxHeartbeats 0 in
noncomputable def tree : KTree := ktree_of_files% "{partdir}/k{i}.bin" "{partdir}/v{i}.bin" {hi - lo} {chunk}

end CS31aK.{name}.{dn(i)}
''')
    fk = {}
    if os.environ.get('FIRSTKEYS'):  # lines "i key": first key of part i (e.g. fetched by byte-range reads)
        for line in open(os.environ['FIRSTKEYS']):
            i, k = line.split(); fk[int(i)] = int(k)
    def firstkey(i):
        if i in fk: return fk[i]
        with open(os.path.join(root, partdir, f'k{i}.bin'), 'rb') as g:
            return int.from_bytes(g.read(8), 'little')
    def top(d, i):  # subtree of depth dd - d over parts i * 2^(dd-d) ..
        if d == dd: return f'{dn(i)}.tree'
        right = (2 * i + 1) << (dd - d - 1)
        return f'(.node {firstkey(right)} {top(d + 1, 2 * i)} {top(d + 1, 2 * i + 1)})'
    imports = '\n'.join(f'import CS31aK.{name}.{dn(i)}' for i in range(2 ** dd))
    with open(os.path.join(DIR, 'Data.lean'), 'w') as f:
        f.write(f'''{imports}

/-! K data, h = {h}: {os.path.basename(keys)} / {os.path.basename(vec)} ({n} entries), leaves of {chunk} entries; the
top {dd} levels over the {2 ** dd} sub-data trees D<i>.tree (split keys = first keys of the right parts). -/

{header}
noncomputable def tree : KTree := {top(0, 0)}

{footer}''')
nmod = 2 ** D // bsz
lb = bsz.bit_length() - 1          # shards per module = 2^lb
assert 2 ** lb == bsz
Dm = D - lb                        # depth of the module subtrees
for m in range(nmod):
    if split_mode:
        body = f'''set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem mod{m} : checkKL {h} tree wt lam (tree.sub {lit(bits(m, Dm))}) = true := by
  kl_split {lb}
'''
        imp = 'import CS31a.KLSplit'
    else:
        thms = []
        for i in range(m * bsz, (m + 1) * bsz):
            thms.append(f'''set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem s{i} : checkKL {h} tree wt lam (tree.sub {lit(bits(i, D))}) = true := by decide +kernel
''')
        body = chr(10).join(thms)
        imp = 'import CS31aCert.KLane'
    with open(os.path.join(DIR, f'S{m}.lean'), 'w') as f:
        f.write(f'''import CS31aK.{name}.Data
{imp}

namespace CS31aK.{name}

{'open CS31a CS31aCert' if split_mode else 'open CS31aCert'}

{body}
end CS31aK.{name}
''')
per_group = 2 ** d2 // bsz
split_fn = 'checkKL_splitC' if split_mode else f'{pre}checkKL_split'
for g in range(2 ** d1):
    imports = '\n'.join(f'import CS31aK.{name}.S{m}' for m in range(g * per_group, (g + 1) * per_group))
    lines = []
    top_d = Dm if split_mode else D
    for d in range(top_d - 1, d1 - 1, -1):
        lo, hi = g << (d - d1), (g + 1) << (d - d1)
        for v in range(lo, hi):
            if d == top_d - 1:
                a, b = (f'mod{2 * v}', f'mod{2 * v + 1}') if split_mode else (f's{2 * v}', f's{2 * v + 1}')
            else:
                a, b = f'a{d + 1}_{2 * v}', f'a{d + 1}_{2 * v + 1}'
            lines.append(f'  have a{d}_{v} := {split_fn} tree {lit(bits(v, d))} {a} {b}')
    if top_d > d1:
        lines.append(f'  exact a{d1}_{g}')
    else:
        lines.append(f'  exact mod{g}' if split_mode else f'  exact s{g}')
    body = '\n'.join(lines)
    gimp = 'import CS31a.KLSplit' if split_mode else f'import {soundmod}'
    with open(os.path.join(DIR, f'G{g}.lean'), 'w') as f:
        f.write(f'''{gimp}
{imports}

namespace CS31aK.{name}

open CS31a CS31aCert

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem group{g} : checkKL {h} tree wt lam (tree.sub {lit(bits(g, d1))}) = true := by
{body}

end CS31aK.{name}
''')
imports = '\n'.join(f'import CS31aK.{name}.G{g}' for g in range(2 ** d1))
lines = [f'  have a{d1}_{g} := group{g}' for g in range(2 ** d1)]
for d in range(d1 - 1, -1, -1):
    for v in range(2 ** d):
        lines.append(f'  have a{d}_{v} := {split_fn} tree {lit(bits(v, d))} a{d + 1}_{2 * v} a{d + 1}_{2 * v + 1}')
lines.append('  exact a0_0')
body = '\n'.join(lines)
with open(os.path.join(root, 'CS31aK', f'{name}.lean'), 'w') as f:
    f.write(f'''import {soundmod}{chr(10) + 'import CS31a.KLSplit' if split_mode else ''}
import CS31a.Assemble
import CS31a.Count
import CS31a.CoverExists
{imports}

/-! Kernel-only proof with the lane-packed checker, h = {h}: `γ₂ ≤ {bound}` (θ' = {p}/{q}, z = {zn}/{zd}, Λ = {lam}).
Standard axioms only. -/

namespace CS31aK.{name}

open CS31a CS31aCert

set_option maxRecDepth 100000 in
theorem global : globalOK {h} tree.findL wt = true := by decide +kernel

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem whole : checkKL {h} tree wt lam tree = true := by
{body}

theorem gamma2_le_of (H : LuekerCriterion {h}) : gamma2 ≤ {bound} := by
  obtain ⟨hfind, hrows⟩ := {pre}checkKL_sound_all (by norm_num) (by norm_num) whole
  have h1 := gamma2_le_of_rows H tree.findL wt lam _ hfind hrows global (zn := {zn}) (zd := {zd}) (by norm_num)
    (by norm_num) (by decide +kernel) (p := {p}) (q := {q}) (by norm_num) (by norm_num) (by decide)
    (by decide +kernel)
  calc gamma2 ≤ (({p} : ℕ) : ℝ) / (({q} : ℕ) : ℝ) := h1
    _ ≤ {bound} := by norm_num

theorem gamma2_le_cover (Hc : CoverExists {h}) : gamma2 ≤ {bound} :=
  gamma2_le_of (luekerCriterion_of_cover Hc)

/-- **Kernel-only, no hypotheses**: `γ₂ ≤ {bound}`. -/
theorem gamma2_le : gamma2 ≤ {bound} := gamma2_le_of (luekerCriterion {h})

end CS31aK.{name}
''')
print('generated', (str(2 ** dd) + ' sub-data modules, ') if dd else '', 2 ** d1, 'groups x', 2 ** d2, 'shards in',
      nmod, 'modules of', bsz)
