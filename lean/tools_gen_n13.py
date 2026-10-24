#!/usr/bin/env python3
"""Generate the N-track modules of a compact certificate checked by `CS31aCert.checkCert13R` (CS31aCert/Check13.lean).

usage: tools_gen_n13.py CONFIG.json [--check-files] [--dry-run]

Layout (Check13): n entries; `low` = key i mod 2^sb in lb bytes LE; `tab` = nb + 1 entries of tb bytes LE (tab[b] = first
index whose key >> sb is >= b); `vec` = binary32 bit patterns, 4 bytes LE. `getC` reads entry i of an array from chunk
i >>> cs at byte offset (i % 2^cs) * w, so chunk c of the concatenated chunk list must hold the entries c * 2^cs ...:
every array is cut into chunks of exactly 2^cs entries (2^cs * w bytes; the last chunk shorter). Each array file is
split into parts of whole chunks (the last part shorter); part p is one module of `chunks_of_file%` literals.

Generated (root = directory of this script, M = config "name", m = M in lower case):
* CS31aData/M/L<p>.lean, T<p>.lean, V<p>.lean: `def l<p>` / `t<p>` / `v<p> : List (Nat × Nat)` in CS31aData.M;
* CS31aData/M.lean: `lowM`, `tabM`, `vecM` (concatenated chunk lists, `List.flatten`) and `wtM`;
* CS31aData/M/C<j>.lean: machine share j: `checkCert13R h lowM tabM vecM n sb lb nb tb cs wtM Λ lo_j hi_j chunks_j = true`
  by `native_decide`;
* CS31aData/MainM.lean (only when the shares cover [0, n)): `rangesM`, `coverM`, `gamma2_le_m_of`, `gamma2_le_m`
  (`checkCert13R_soundR`, `gamma2_le_of_rows`).

Config (JSON object):
  name                  module name, e.g. "N13"
  title                 one line for the module docs (provenance: input files, sha256)
  h, n, sb, lb, nb, tb, cs
  low, tab, vec         {"file": path (relative to the root), "chunks_per_part": k}: parts FILE.part<p>, p in decimal
                        with `suffix_digits` digits, i.e. made by `split -b <k * 2^cs * w> -d -a <digits> FILE FILE.part`;
                        or {"parts": [[path, bytes], ...]}: explicit parts (all but the last hold whole chunks)
  suffix_digits         optional (default: max(3, number of digits of the largest part index))
  wt                    the h weights (cert_weights.py), checked against z = zn/zd as `weightsOK`
  lam                   Λ (lam_num of the certificate)
  zn, zd                z = zn/zd
  p, q, bound           θ' = p/q <= bound (decimal string) with Λ^p zd^(2q) < (2 zn)^(2q) 2^(64 p) (Main only)
  shares                explicit [[lo, hi, chunks], ...]
    or share_weights, share_chunks: ranges over [0, n) by cumulative weight (as tools_gen_h12.py)
  main                  optional bool; default: true iff the shares are contiguous from 0 to n
  max_chunk_bytes       optional, default 2^25: the kernel refuses Nat literals above ~51 MB, so
                        2^cs * max(lb, tb, 4) must stay below this (tb = 5: cs <= 22)

--dry-run: all checks and the summary, no files written.
--check-files: compare the sizes of the part files present under the root with the layout (missing parts are listed;
on a machine without the data only the layout is printed).

Build: NOT with `lake build` (Lake also emits C for every CS31aData module, and the C emission of the big literals does
not finish: a 59 MB part ran > 10 min after its olean was written in 3 s). Build each module's olean directly, in the
printed order:
  LEAN_PATH=$(lake env printenv LEAN_PATH) lean --load-dynlib=.lake/build/lib/lean/CS31a_CS31aCert_<M>.so ... \
    CS31aData/M/X.lean -o .lake/build/lib/lean/CS31aData/M/X.olean -i .lake/build/lib/lean/CS31aData/M/X.ilean
with the dynlibs of Bytes (compiled `natOfBytes` for `chunks_of_file%`), Step, Row, KTree, Check, KStep, Check2, Check13
(compiled checker for `native_decide`). `lean --threads=K` bounds the decoding tasks of `chunksPar` (the environment
variable LEAN_NUM_THREADS does not); the row tasks of a share are dedicated threads (`chunks` of them).
"""
import io, json, os, re, sys
from fractions import Fraction

root = os.path.dirname(os.path.abspath(__file__))


def die(msg):
    sys.exit('tools_gen_n13: ' + msg)


args = [a for a in sys.argv[1:] if not a.startswith('--')]
flags = {a for a in sys.argv[1:] if a.startswith('--')}
if len(args) != 1 or not flags <= {'--check-files', '--dry-run'}:
    die('usage: tools_gen_n13.py CONFIG.json [--check-files] [--dry-run]')
DRY = '--dry-run' in flags


def wopen(path):
    return io.StringIO() if DRY else open(path, 'w')


with open(args[0]) as f:
    cfg = json.load(f)

M = cfg['name']
if not (M[:1].isupper() and M.isalnum()):
    die('name must be alphanumeric and start with an upper-case letter')
m = M.lower()
title = cfg.get('title', f'compact certificate {M}')
h, n, sb, lb, nb, tb, cs = (int(cfg[k]) for k in ('h', 'n', 'sb', 'lb', 'nb', 'tb', 'cs'))
wt = [int(x) for x in cfg['wt']]
lam = int(cfg['lam'])
zn, zd = int(cfg['zn']), int(cfg['zd'])

# ---- layout checks ----
if not (2 <= h <= 16 and n >= 1 and nb >= 1 and cs >= 0):
    die('bad h, n, nb or cs')
if sb > 8 * lb:
    die(f'low bits do not fit: sb = {sb} > 8 lb = {8 * lb}')
if n >= 256 ** tb:
    die(f'table entries (indices <= n = {n}) do not fit in tb = {tb} bytes')
if 4 * h > sb + (nb - 1).bit_length():
    print(f'note: keys < 2^{4 * h} need nb > 2^{4 * h - sb} buckets of 2^{sb} codes (nb = {nb}); the row test rejects '
          f'keys outside the table')
if len(wt) != h:
    die(f'{len(wt)} weights for h = {h}')
if not (0 < zn and 2 * zn < zd):
    die('need 0 < zn and 2 zn < zd')
for k in range(h):          # weightsOK (CS31a/Assemble.lean)
    ok = (2 ** 64 * zn ** (k + 2) <= wt[k] * zd ** (k + 2)) if k + 1 < h else \
        (2 ** 64 * zn ** (h + 1) <= wt[k] * (zd ** h * (zd - zn)))
    if not ok:
        die(f'weightsOK fails at k = {k} for z = {zn}/{zd}')
if not 0 < lam < 2 ** 64:
    die('need 0 < lam < 2^64')

# ---- parts ----
CH = 2 ** cs
maxcb = int(cfg.get('max_chunk_bytes', 2 ** 25))
if CH * max(lb, tb, 4) > maxcb:
    die(f'chunks of 2^{cs} entries have up to {CH * max(lb, tb, 4)} bytes > max_chunk_bytes = {maxcb} (Nat literal '
        f'limit); use cs <= {(maxcb // max(lb, tb, 4)).bit_length() - 1}')
arrays = []                 # (kind letter, def prefix, doc, file label, entries, width, parts [(path, bytes)])
for kind, key, ent, w, doc in (('L', 'low', n, lb, f'key mod 2^{sb}, {lb} bytes LE per entry'),
                               ('T', 'tab', nb + 1, tb, f'bucket table, {tb} bytes LE per entry'),
                               ('V', 'vec', n, 4, 'binary32 value bits, 4 bytes LE per entry')):
    spec = cfg[key]
    total, cb = ent * w, CH * w
    if 'parts' in spec:
        parts = [(str(p), int(b)) for p, b in spec['parts']]
    else:
        k = int(spec['chunks_per_part'])
        if k < 1 or 'file' not in spec:
            die(f'{key}: needs "file" and a positive "chunks_per_part"')
        pb = k * cb
        np_ = (total + pb - 1) // pb
        parts = [(None, pb if i < np_ - 1 else total - (np_ - 1) * pb) for i in range(np_)]
    if not parts or sum(b for _, b in parts) != total:
        die(f'{key}: parts hold {sum(b for _, b in parts)} bytes, expected {ent} * {w} = {total}')
    for i, (_, b) in enumerate(parts):
        if b <= 0 or (i < len(parts) - 1 and b % cb):
            die(f'{key}: part {i} has {b} bytes, not a positive multiple of the chunk size {cb}')
    arrays.append([kind, key, doc, spec.get('file'), ent, w, parts, cb])
digits = int(cfg.get('suffix_digits', max(3, len(str(max(len(a[6]) for a in arrays) - 1)))))
for a in arrays:
    if a[3] is not None and a[6][0][0] is None:
        a[6] = [(f'{a[3]}.part{i:0{digits}d}', b) for i, (_, b) in enumerate(a[6])]
    for path, _ in a[6]:
        if '"' in path or '\\' in path:
            die(f'bad path {path}')

# ---- shares ----
if 'shares' in cfg:
    ranges = [(int(lo), int(hi), int(ch)) for lo, hi, ch in cfg['shares']]
else:
    weights = [float(x) for x in cfg['share_weights']]
    chunks = [int(x) for x in cfg.get('share_chunks', [1] * len(weights))]
    if len(chunks) != len(weights):
        die('share_chunks and share_weights differ in length')
    tot = sum(weights)
    bps, acc = [0], 0.0
    for x in weights[:-1]:
        acc += x
        bps.append(round(n * acc / tot))
    bps.append(n)
    ranges = [(bps[j], bps[j + 1], chunks[j]) for j in range(len(weights))]
if not ranges:
    die('no shares')
for lo, hi, ch in ranges:
    if not (0 <= lo < hi <= n and ch >= 1):
        die(f'bad share ({lo}, {hi}, {ch})')
contiguous = ranges[0][0] == 0 and ranges[-1][1] == n and all(ranges[j][1] == ranges[j + 1][0]
                                                              for j in range(len(ranges) - 1))
main = bool(cfg.get('main', contiguous))
if main and not contiguous:
    die('Main needs shares contiguous from 0 to n (the cover proof); set "main": false for a partial test')
if main:
    p, q, bound = int(cfg['p']), int(cfg['q']), str(cfg['bound'])
    if not (p > 0 and q > 0):
        die('need p, q > 0')
    if Fraction(p, q) > Fraction(bound):
        die(f'p/q = {p}/{q} > bound {bound}')
    if not lam ** p * zd ** (2 * q) < (2 * zn) ** (2 * q) * 2 ** (64 * p):
        die(f'θ\' = {p}/{q} fails: Λ^p zd^(2q) >= (2 zn)^(2q) 2^(64 p)')

# ---- files ----
D = os.path.join(root, 'CS31aData', M)
if not DRY:
    os.makedirs(D, exist_ok=True)
NS = f'CS31aData.{M}'
for kind, key, doc, label, ent, w, parts, cb in arrays:
    e0 = 0
    for i, (path, b) in enumerate(parts):
        e1 = e0 + b // w if i < len(parts) - 1 else ent
        c0 = e0 // CH
        nch = (b + cb - 1) // cb
        with wopen(os.path.join(D, f'{kind}{i}.lean')) as f:
            f.write(f'''import CS31aData.Elab

/-! {M} data, {key} ({doc}): part {i} = {path}, entries {e0} .. {e1 - 1}, chunks {c0} .. {c0 + nch - 1}
of 2^{cs} entries ({cb} bytes). -/

namespace {NS}

set_option maxHeartbeats 0 in
def {kind.lower()}{i} : List (Nat × Nat) :=
  chunks_of_file% "{path}" {b} {cb}

end {NS}
''')
        e0 = e1

imports = '\n'.join(f'import {NS}.{a[0]}{i}' for a in arrays for i in range(len(a[6])))


def concat(kind, cnt):
    return 'List.flatten [' + ', '.join(f'{M}.{kind.lower()}{i}' for i in range(cnt)) + ']'


lowL, tabL, vecL = (concat(a[0], len(a[6])) for a in arrays)
wts = ', '.join(str(x) for x in wt)
with wopen(os.path.join(root, 'CS31aData', f'{M}.lean')) as f:
    f.write(f'''import CS31aCert.Check13
{imports}

/-! {M}: {title}.
Compact layout (CS31aCert/Check13.lean): h = {h}, n = {n}, sb = {sb}, lb = {lb}, nb = {nb}, tb = {tb}; chunks of 2^{cs}
entries; parts: low {len(arrays[0][6])}, tab {len(arrays[1][6])}, vec {len(arrays[2][6])}. -/

namespace CS31aData

/-- Low bits of the keys, chunks of 2^{cs} entries. -/
def low{M} : List (Nat × Nat) := {lowL}
/-- The bucket table, chunks of 2^{cs} entries. -/
def tab{M} : List (Nat × Nat) := {tabL}
/-- The binary32 values, chunks of 2^{cs} entries. -/
def vec{M} : List (Nat × Nat) := {vecL}

/-- `⌈2^64 w_z(k)⌉`, `k = 0..{h - 1}`, `z = {zn}/{zd}`. -/
def wt{M} : List Nat := [{wts}]

end CS31aData
''')

args13 = f'{h} low{M} tab{M} vec{M} {n} {sb} {lb} {nb} {tb} {cs} wt{M}'
for j, (lo, hi, ch) in enumerate(ranges):
    with wopen(os.path.join(D, f'C{j}.lean')) as f:
        f.write(f'''import {NS}

/-! {M}, machine share {j} of {len(ranges)}: rows [{lo}, {hi}) in {ch} parallel task(s), with the decoding, the table check
and `globalOK`. -/

namespace {NS}

set_option maxHeartbeats 0 in
theorem cert{j} : CS31aCert.checkCert13R {args13}
    {lam} {lo} {hi} {ch} = true := by
  native_decide

end {NS}
''')

mainf = os.path.join(root, 'CS31aData', f'Main{M}.lean')
if main:
    cimports = '\n'.join(f'import {NS}.C{j}' for j in range(len(ranges)))
    rlist = ', '.join(f'({lo}, {hi}, {ch})' for lo, hi, ch in ranges)
    cases = ' | '.join(['rfl'] * len(ranges))
    certs = ', '.join(f'{M}.cert{j}' for j in range(len(ranges)))
    covlines = [f'  by_cases h{j} : i < {hi}\n  · exact ⟨({lo}, {hi}, {ch}), by simp, by omega, h{j}⟩'
                for j, (lo, hi, ch) in enumerate(ranges)]
    covproof = '\n'.join(covlines) + '\n  omega'
    r0 = ranges[0]
    with wopen(mainf) as f:
        f.write(f'''import CS31a.Assemble
import CS31a.CheckNative13
import CS31a.Count
import CS31a.CoverExists
{cimports}

/-! {M}: `γ₂ ≤ {bound}` from the native check of the compact certificate ({title}), split over {len(ranges)}
machine shares (row ranges). The exact test uses `θ' = {p}/{q} ≤ {bound}`. -/

namespace CS31aData

open CS31a CS31aCert

theorem ranges{M} : ∀ r ∈ ([{rlist}] : List (ℕ × ℕ × ℕ)),
    checkCert13R {args13} {lam} r.1 r.2.1 r.2.2 = true := by
  intro r hr
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hr
  rcases hr with {cases}
  exacts [{certs}]

theorem cover{M} : ∀ i < {n}, ∃ r ∈ ([{rlist}] : List (ℕ × ℕ × ℕ)), r.1 ≤ i ∧ i < r.2.1 := by
  intro i hi
{covproof}

theorem gamma2_le_{m}_of (H : LuekerCriterion {h}) : gamma2 ≤ {bound} := by
  obtain ⟨hfind, hrows, hglob⟩ := checkCert13R_soundR _ ranges{M} ({r0[0]}, {r0[1]}, {r0[2]}) (by simp) cover{M}
  have h1 := gamma2_le_of_rows H _ _ _ _ hfind hrows hglob (zn := {zn}) (zd := {zd}) (by norm_num) (by norm_num)
    (by decide +kernel) (p := {p}) (q := {q}) (by norm_num) (by norm_num) (by norm_num) (by decide +kernel)
  calc gamma2 ≤ (({p} : ℕ) : ℝ) / (({q} : ℕ) : ℝ) := h1
    _ ≤ {bound} := by norm_num

/-- **No hypotheses** (native check of the compact certificate {M}): `γ₂ ≤ {bound}`. -/
theorem gamma2_le_{m} : gamma2 ≤ {bound} := gamma2_le_{m}_of (luekerCriterion {h})

end CS31aData
''')
elif os.path.exists(mainf) and not DRY:
    die(f'{mainf} exists but the shares do not cover [0, n): remove it')

# stale part/share modules of an earlier generation with more parts or shares
wanted = {f'{a[0]}{i}.lean' for a in arrays for i in range(len(a[6]))} | {f'C{j}.lean' for j in range(len(ranges))}
for fn in ([] if DRY else sorted(os.listdir(D))):
    if re.fullmatch(r'[LTVC][0-9]+\.lean', fn) and fn not in wanted:
        os.remove(os.path.join(D, fn))
        print(f'removed stale CS31aData/{M}/{fn}')

# ---- summary ----
for kind, key, doc, label, ent, w, parts, cb in arrays:
    sizes = sorted({b for _, b in parts})
    print(f'{key}: {ent} entries x {w} B = {ent * w} B, chunk {cb} B, {len(parts)} part(s) of {parts[0][1]} B '
          f'(last {parts[-1][1]} B)')
    if label is not None and 'chunks_per_part' in cfg[key]:
        print(f'  split -b {parts[0][1]} -d -a {digits} {label} {label}.part')
    if '--check-files' in flags:
        missing = 0
        for path, b in parts:
            fp = os.path.join(root, path)
            if not os.path.exists(fp):
                missing += 1
            elif os.path.getsize(fp) != b:
                die(f'{path}: {os.path.getsize(fp)} bytes, expected {b}')
        print(f'  files: {len(parts) - missing} present with the expected sizes, {missing} missing')
for j, r in enumerate(ranges):
    print('share', j, r)
print('Main:', f'CS31aData/Main{M}.lean (gamma2_le_{m} : gamma2 <= {cfg["bound"]})' if main else 'not generated '
      '(the shares do not cover [0, n))')
print(f'build order: {sum(len(a[6]) for a in arrays)} part modules {NS}.{{L,T,V}}<p> (independent), then {NS}, then '
      f'the shares {NS}.C0 .. C{len(ranges) - 1} (independent)' + (f', then CS31aData.Main{M}' if main else ''))
