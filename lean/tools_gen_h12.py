#!/usr/bin/env python3
"""Generate the h = 12 N-track modules (deterministic vector of record).

* CS31aData/H12/K<i>.lean, V<i>.lean: part i of h12_keys.bin / h12_vdet_0.350500.bin. The files are split (on each
  machine, while streaming them from the bucket) into parts of 50031665 entries (400253320 bytes; the last part shorter)
  named <file>.part<iii> (3 digits, `split -b 400253320 -d -a 3`); each part is one module of `chunks_of_file%` literals
  (chunks of at most 2^25 bytes).
* CS31aData/H12.lean: the concatenated chunk lists and the weights.
* CS31aData/H12/C<j>.lean: machine share j, `checkCertChunksR2` (decode, radix table, global conditions, rows
  [lo_j, hi_j)) by `native_decide`.
* CS31aData/MainH12.lean: combines the shares (`checkCertChunksR2_soundR`) into `gamma2 ≤ 0.822579`.
usage: tools_gen_h12.py W0,W1,...   (relative speed weights of the machines; one share per weight)
"""
import os, sys

N = 22670087101
PER = 50031665
NP = (N + PER - 1) // PER
S, NB = 19, 2 ** 29            # radix: buckets of 2^19 codes (codes < 2^48), 2^29 buckets
LAM = 7776813894375449830      # Λ of the deterministic vector of record (frozen check log)
WT = [2266187121141236844, 794298585960003514, 278401654378981232, 97579779859832922, 34201712840871440,
      11987700350725440, 4201688972929267, 1472691985011708, 516178540746604, 180920578531685, 63412662775356,
      34220382298325]
ZN, ZD, P, Q, BOUND = 701, 2000, 5851, 7113, '0.822579'
KF, VF = 'h12_keys.bin', 'h12_vdet_0.350500.bin'

weights = [float(x) for x in sys.argv[1].split(',')]
chunks = [int(x) for x in sys.argv[2].split(',')] if len(sys.argv) > 2 else [448] * len(weights)
tot = sum(weights)
bps = [0]
acc = 0.0
for w in weights[:-1]:
    acc += w
    bps.append(round(N * acc / tot))
bps.append(N)
ranges = [(bps[j], bps[j + 1], chunks[j]) for j in range(len(weights))]

root = os.path.dirname(os.path.abspath(__file__))
D = os.path.join(root, 'CS31aData', 'H12')
os.makedirs(D, exist_ok=True)
parts = [(i, PER if i < NP - 1 else N - (NP - 1) * PER) for i in range(NP)]
for kind, fname in (('K', KF), ('V', VF)):
    for i, cnt in parts:
        with open(os.path.join(D, f'{kind}{i}.lean'), 'w') as f:
            f.write(f'''import CS31aData.Elab

/-! h = 12 data: part {i} of {fname} (entries {i * PER} .. {i * PER + cnt - 1}). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def {kind.lower()}{i} : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/{fname}.part{i:03d}" {8 * cnt} 33554432

end CS31aData.H12
''')
imports = '\n'.join(f'import CS31aData.H12.{k}{i}' for k in 'KV' for i, _ in parts)
keys = ' ++ '.join(f'H12.k{i}' for i, _ in parts)
vecs = ' ++ '.join(f'H12.v{i}' for i, _ in parts)
wts = ', '.join(str(w) for w in WT)
with open(os.path.join(root, 'CS31aData', 'H12.lean'), 'w') as f:
    f.write(f'''import CS31aCert.Check2
{imports}

/-! h = 12, z = 0.3505: the published certificate with the deterministic vector of record (h12_keys.bin sha256
bef385e5…, h12_vdet_0.350500.bin sha256 915ac393…), {NP} parts per file, chunks of at most 2^25 bytes. -/

namespace CS31aData

def keysH12 : List (Nat × Nat) := {keys}
def vecH12 : List (Nat × Nat) := {vecs}

/-- `⌈2^64 w_z(k)⌉`, `k = 0..11`, `z = 701/2000` (w_h12_0.3505.txt). -/
def wtH12 : List Nat := [{wts}]

end CS31aData
''')
for j, (lo, hi, ch) in enumerate(ranges):
    with open(os.path.join(D, f'C{j}.lean'), 'w') as f:
        f.write(f'''import CS31aData.H12

/-! h = 12, machine share {j} of {len(ranges)}: rows [{lo}, {hi}). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
theorem cert{j} : CS31aCert.checkCertChunksR2 12 keysH12 vecH12 {N} {S} {NB} wtH12 {LAM} {lo} {hi} {ch} = true := by
  native_decide

end CS31aData.H12
''')
cimports = '\n'.join(f'import CS31aData.H12.C{j}' for j in range(len(ranges)))
rlist = ', '.join(f'({lo}, {hi}, {ch})' for lo, hi, ch in ranges)
cases = ' | '.join(['rfl'] * len(ranges))
certs = ', '.join(f'H12.cert{j}' for j in range(len(ranges)))
cov = '\n'.join(f'  · exact ⟨_, by simp, by norm_num, h{j}⟩' if False else '' for j in range(0))
covlines = []
for j, (lo, hi, ch) in enumerate(ranges):
    covlines.append(f'  by_cases h{j} : i < {hi}\n  · exact ⟨({lo}, {hi}, {ch}), by simp, by omega, h{j}⟩')
covproof = '\n'.join(covlines) + '\n  omega'
with open(os.path.join(root, 'CS31aData', 'MainH12.lean'), 'w') as f:
    f.write(f'''import CS31a.Assemble
import CS31a.CheckNative2
import CS31a.Count
import CS31a.CoverExists
{cimports}

/-! h = 12: `γ₂ ≤ {BOUND}` from the native check of the published certificate with the deterministic vector of record,
split over {len(ranges)} machines (row ranges). The exact test uses `θ' = {P}/{Q} ≤ {BOUND}`. -/

namespace CS31aData

open CS31a CS31aCert

theorem rangesH12 : ∀ r ∈ ([{rlist}] : List (ℕ × ℕ × ℕ)),
    checkCertChunksR2 12 keysH12 vecH12 {N} {S} {NB} wtH12 {LAM} r.1 r.2.1 r.2.2 = true := by
  intro r hr
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hr
  rcases hr with {cases}
  exacts [{certs}]

theorem coverH12 : ∀ i < {N}, ∃ r ∈ ([{rlist}] : List (ℕ × ℕ × ℕ)), r.1 ≤ i ∧ i < r.2.1 := by
  intro i hi
{covproof}

theorem gamma2_le_h12_of (H : LuekerCriterion 12) : gamma2 ≤ {BOUND} := by
  obtain ⟨hfind, hrows, hglob⟩ := checkCertChunksR2_soundR _ rangesH12 ({ranges[0][0]}, {ranges[0][1]}, {ranges[0][2]}) (by simp) coverH12
  have h1 := gamma2_le_of_rows H _ _ _ _ hfind hrows hglob (zn := {ZN}) (zd := {ZD}) (by norm_num) (by norm_num)
    (by decide +kernel) (p := {P}) (q := {Q}) (by norm_num) (by norm_num) (by norm_num) (by decide +kernel)
  calc gamma2 ≤ (({P} : ℕ) : ℝ) / (({Q} : ℕ) : ℝ) := h1
    _ ≤ {BOUND} := by norm_num

/-- **No hypotheses** (native check of the published certificate, deterministic vector): `γ₂ ≤ {BOUND}`. -/
theorem gamma2_le_h12 : gamma2 ≤ {BOUND} := gamma2_le_h12_of (luekerCriterion 12)

end CS31aData
''')
for j, r in enumerate(ranges):
    print('share', j, r)
print('parts per file', NP, 'last part entries', parts[-1][1])
