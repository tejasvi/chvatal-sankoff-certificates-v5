#!/usr/bin/env python3
"""Generate the kernel-only (K) modules for M_h with recursor-based shards and binary-split combination:
  CS31aK/<name>/Data.lean      KTree literal (noncomputable), weights, Lambda
  CS31aK/<name>/S<m>.lean      B shard theorems s<i> : checkKF h tree wt lam (tree.sub path_i) = true (decide +kernel),
                               path_i = the D = D1 + D2 bits of i (most significant first), i = m B .. m B + B - 1
  CS31aK/<name>/G<g>.lean      group g: checkK on tree.sub (first D1 bits of g), from its 2^D2 shards by checkK_split
  CS31aK/<name>.lean           global check, the whole tree from the 2^D1 groups by checkK_split, final theorems
usage: tools_gen_k5.py H KEYS VEC N CHUNK D1 D2 B LAM ZN ZD P Q BOUND W0,W1,...  (module name H<h>, or $KNAME)
"""
import os, sys, shutil
h, keys, vec, n, chunk, d1, d2, bsz, lam, zn, zd, p, q, bound, wts = sys.argv[1:16]
h = int(h); n = int(n); chunk = int(chunk); d1 = int(d1); d2 = int(d2); bsz = int(bsz)
D = d1 + d2
assert (2 ** d2) % bsz == 0
wt = [int(x) for x in wts.split(',')]
root = os.path.dirname(os.path.abspath(__file__))
name = os.environ.get('KNAME', f'H{h}')
DIR = os.path.join(root, 'CS31aK', name)
if os.path.isdir(DIR): shutil.rmtree(DIR)
os.makedirs(DIR)
def bits(v, d): return [bool((v >> (d - 1 - j)) & 1) for j in range(d)]
def lit(bs): return '[' + ', '.join('true' if b else 'false' for b in bs) + ']'
with open(os.path.join(DIR, 'Data.lean'), 'w') as f:
    f.write(f'''import CS31aData.KElab

/-! K data, h = {h}: {os.path.basename(keys)} / {os.path.basename(vec)} ({n} entries), leaves of {chunk} entries. -/

namespace CS31aK.{name}

open CS31aCert

set_option maxRecDepth 1000000 in
set_option maxHeartbeats 0 in
noncomputable def tree : KTree := ktree_of_files% "{keys}" "{vec}" {n} {chunk}

def wt : List Nat := {wt}

def lam : Nat := {lam}

end CS31aK.{name}
''')
nmod = 2 ** D // bsz
for m in range(nmod):
    thms = []
    for i in range(m * bsz, (m + 1) * bsz):
        thms.append(f'''set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem s{i} : checkKF {h} tree wt lam (tree.sub {lit(bits(i, D))}) = true := by decide +kernel
''')
    with open(os.path.join(DIR, f'S{m}.lean'), 'w') as f:
        f.write(f'''import CS31aK.{name}.Data
import CS31aCert.KFast

namespace CS31aK.{name}

open CS31aCert

{chr(10).join(thms)}
end CS31aK.{name}
''')
per_group = 2 ** d2 // bsz
for g in range(2 ** d1):
    imports = '\n'.join(f'import CS31aK.{name}.S{m}' for m in range(g * per_group, (g + 1) * per_group))
    lines = [f'  have hh : 1 ≤ {h} := by norm_num'] + [f'  have a{D}_{i} := checkK_of_KF hh s{i}' for i in range(g * 2 ** d2, (g + 1) * 2 ** d2)]
    for d in range(D - 1, d1 - 1, -1):
        lo, hi = g << (d - d1), (g + 1) << (d - d1)
        for v in range(lo, hi):
            lines.append(f'  have a{d}_{v} := checkK_split tree {lit(bits(v, d))} a{d + 1}_{2 * v} a{d + 1}_{2 * v + 1}')
    lines.append(f'  exact a{d1}_{g}')
    body = '\n'.join(lines)
    with open(os.path.join(DIR, f'G{g}.lean'), 'w') as f:
        f.write(f'''import CS31a.KSplit
{imports}

namespace CS31aK.{name}

open CS31a CS31aCert

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem group{g} : checkK {h} tree wt lam (tree.sub {lit(bits(g, d1))}) = true := by
{body}

end CS31aK.{name}
''')
imports = '\n'.join(f'import CS31aK.{name}.G{g}' for g in range(2 ** d1))
lines = [f'  have a{d1}_{g} := group{g}' for g in range(2 ** d1)]
for d in range(d1 - 1, -1, -1):
    for v in range(2 ** d):
        lines.append(f'  have a{d}_{v} := checkK_split tree {lit(bits(v, d))} a{d + 1}_{2 * v} a{d + 1}_{2 * v + 1}')
lines.append('  exact a0_0')
body = '\n'.join(lines)
with open(os.path.join(root, 'CS31aK', f'{name}.lean'), 'w') as f:
    f.write(f'''import CS31a.KSplit
import CS31a.Assemble
import CS31a.Count
import CS31a.CoverExists
{imports}

/-! Kernel-only proof, h = {h}: `γ₂ ≤ {bound}` (θ' = {p}/{q}, z = {zn}/{zd}, Λ = {lam}). Standard axioms only. -/

namespace CS31aK.{name}

open CS31a CS31aCert

set_option maxRecDepth 100000 in
theorem global : globalOK {h} tree.find wt = true := by decide +kernel

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem whole : checkK {h} tree wt lam tree = true := by
{body}

theorem gamma2_le_of (H : LuekerCriterion {h}) : gamma2 ≤ {bound} := by
  obtain ⟨hfind, hrows⟩ := checkK_sound_all whole
  have h1 := gamma2_le_of_rows H tree.find wt lam _ hfind hrows global (zn := {zn}) (zd := {zd}) (by norm_num)
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
print('generated', 2 ** d1, 'groups x', 2 ** d2, 'shards in', nmod, 'modules of', bsz)
