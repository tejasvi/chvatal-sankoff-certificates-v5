import CS31aCert.Check2

/-!
# Native checker for compact certificates (h = 13; core Lean only, compiled)

Layout of a certificate with `n` entries, keys `< 2^(sb + 32)`:
* `low`: the low `sb` bits of key `i`, in `lb` bytes (little-endian), entry `i`;
* `tab`: the bucket table, `nb + 1` entries of `tb` bytes: `tab b` = index of the first key with top bits `≥ b`
  (top bits = key `>>> sb`); the key of entry `i` is `(b <<< sb) ||| low i` for the bucket `b` with
  `tab b ≤ i < tab (b + 1)`;
* `vec`: the value of entry `i` as an IEEE binary32 bit pattern (4 bytes), converted exactly to binary64 bits
  (`f32to64`; binary32 subnormals become normal binary64 values; zero, negative, infinite or NaN patterns map to `0`,
  which no row accepts).

Each of the three arrays is given as chunks of `2^cs` entries, decoded in parallel into separate byte arrays (no
concatenation). The bucket of entry `i` is found by bisection in `tab` (`bucketOf`) and re-checked
(`tab b ≤ i < tab (b + 1)`, `b < nb`) by the row test; the table is checked to be monotone, so these intervals are
disjoint and the key of an entry is well defined. A lookup takes the bucket of the code, bisects the low bits in it and
re-checks `low j = code % 2^sb`. Rows use `rowOK` (`stepCode`).
-/

namespace CS31aCert

/-- Little-endian number of the `w` bytes at byte offset `o` of `b` (bytes past the end read as 0). -/
@[inline] def getLE (b : ByteArray) (o : Nat) : Nat → Nat
  | 0 => 0
  | w + 1 => (b.get! o).toNat + 256 * getLE b (o + 1) w

/-- Entry `i` (`w` bytes) of an array of chunks of `2^cs` entries each. -/
@[inline] def getC (arr : Array ByteArray) (cs w i : Nat) : Nat :=
  getLE (arr.getD (i >>> cs) ByteArray.empty) ((i % 2 ^ cs) * w) w

/-- A compact certificate (decoded chunks and layout parameters). -/
structure Cert13 where
  low : Array ByteArray
  tab : Array ByteArray
  vec : Array ByteArray
  n : Nat
  sb : Nat
  lb : Nat
  nb : Nat
  tb : Nat
  cs : Nat

/-- Exact binary32 → binary64 bit pattern (`0` for zero, negative, infinite or NaN). -/
def f32to64 (u : Nat) : Nat :=
  let e := (u >>> 23) % 256
  let f := u % 8388608
  if 2 ^ 31 ≤ u ∨ e = 255 ∨ (e = 0 ∧ f = 0) then 0
  else if e ≠ 0 then ((e + 896) <<< 52) ||| (f <<< 29)
  else
    let p := f.log2
    ((874 + p) <<< 52) ||| ((f <<< (52 - p)) - 2 ^ 52)

namespace Cert13

@[inline] def tabAt (C : Cert13) (b : Nat) : Nat := getC C.tab C.cs C.tb b
@[inline] def lowAt (C : Cert13) (i : Nat) : Nat := getC C.low C.cs C.lb i
@[inline] def valAt (C : Cert13) (i : Nat) : Nat := f32to64 (getC C.vec C.cs 4 i)

/-- Largest `b` in `[lo, hi)` with `tab b ≤ i` (bisection, fuel-bounded; `lo` if none). -/
def bucketSearch (C : Cert13) (i : Nat) : Nat → Nat → Nat → Nat
  | 0, lo, _ => lo
  | fuel + 1, lo, hi =>
    if hi ≤ lo + 1 then lo
    else
      let mid := (lo + hi) / 2
      if C.tabAt mid ≤ i then bucketSearch C i fuel mid hi else bucketSearch C i fuel lo mid

/-- The bucket of entry `i` (re-checked by the row test). -/
@[inline] def bucketOf (C : Cert13) (i : Nat) : Nat := C.bucketSearch i 64 0 C.nb

/-- The key of entry `i`. -/
@[inline] def keyOf (C : Cert13) (i : Nat) : Nat := (C.bucketOf i <<< C.sb) ||| C.lowAt i

/-- First index in `[lo, hi)` whose low bits are `≥ x` (`hi` if none; fuel-bounded). -/
def lowSearch (C : Cert13) (x : Nat) : Nat → Nat → Nat → Nat
  | 0, lo, _ => lo
  | fuel + 1, lo, hi =>
    if lo < hi then
      let mid := (lo + hi) / 2
      if C.lowAt mid < x then lowSearch C x fuel (mid + 1) hi else lowSearch C x fuel lo mid
    else lo

/-- The index of the code `t`, if listed (re-checked: `j < n`, `j` in the bucket of `t`, low bits of `t`). -/
@[inline] def find (C : Cert13) (t : Nat) : Option Nat :=
  let b := t >>> C.sb
  let x := t % 2 ^ C.sb
  if b < C.nb then
    let lo := C.tabAt b
    let hi := C.tabAt (b + 1)
    let j := C.lowSearch x 64 lo hi
    if lo ≤ j && j < hi && j < C.n && C.lowAt j == x then some j else none
  else none

/-- The lookup: the value bits of a listed code. -/
@[inline] def findVal (C : Cert13) (t : Nat) : Option Nat := (C.find t).map C.valAt

/-- Row `i`: its bucket passes the re-check, and `rowOK` holds for its key and value. -/
@[inline] def rowOK13 (h : Nat) (C : Cert13) (wt : List Nat) (lam i : Nat) : Bool :=
  let b := C.bucketOf i
  b < C.nb && C.tabAt b ≤ i && i < C.tabAt (b + 1) &&
    rowOK h C.findVal wt lam ((b <<< C.sb) ||| C.lowAt i) (C.valAt i)

/-- Rows `lo, lo+1, …, lo+cnt-1`. -/
def rowsOK13 (h : Nat) (C : Cert13) (wt : List Nat) (lam : Nat) : Nat → Nat → Bool
  | _, 0 => true
  | lo, cnt + 1 => rowOK13 h C wt lam lo && rowsOK13 h C wt lam (lo + 1) cnt

/-- `tab b ≤ tab (b + 1)` for `b = lo, …, lo+cnt-1`. -/
def monoOK (C : Cert13) : Nat → Nat → Bool
  | _, 0 => true
  | lo, cnt + 1 => C.tabAt lo ≤ C.tabAt (lo + 1) && monoOK C (lo + 1) cnt

/-- The table is monotone on `[0, nb]` (checked in `parts` parallel tasks). -/
def tabMono (C : Cert13) (parts : Nat) : Bool :=
  let size := (C.nb + parts - 1) / max parts 1
  let tasks := (List.range parts).map fun p =>
    Task.spawn (prio := .dedicated) fun _ => monoOK C (p * size) (min size (C.nb - min C.nb (p * size)))
  Nat.ble C.nb (parts * size) && tasks.all (·.get)

/-- Rows `lo ≤ i < hi`, `chunks` parallel tasks. -/
def checkRange13 (h : Nat) (C : Cert13) (wt : List Nat) (lam lo hi chunks : Nat) : Bool :=
  let cnt := hi - lo
  let size := (cnt + chunks - 1) / max chunks 1
  let tasks := (List.range chunks).map fun c =>
    Task.spawn (prio := .dedicated) fun _ =>
      rowsOK13 h C wt lam (lo + c * size) (min size (cnt - min cnt (c * size)))
  Nat.ble cnt (chunks * size) && tasks.all (·.get)

end Cert13

/-- Decode literal chunks (literal, byte length) into separate byte arrays, one task per chunk. -/
def chunksPar (cs : List (Nat × Nat)) : Array ByteArray :=
  ((cs.map fun c => Task.spawn fun _ => natToBytes c.1 c.2).map Task.get).toArray

/-- One machine's share of a compact certificate given as literal chunks: decode, the global conditions (monotone
table, `globalOK`) and the rows `lo ≤ i < hi`. Several such checks whose ranges cover `[0, n)` give the whole
certificate. -/
def checkCert13R (h : Nat) (lowCs tabCs vecCs : List (Nat × Nat)) (n sb lb nb tb cs : Nat) (wt : List Nat)
    (lam lo hi chunks : Nat) : Bool :=
  let C : Cert13 := ⟨chunksPar lowCs, chunksPar tabCs, chunksPar vecCs, n, sb, lb, nb, tb, cs⟩
  C.tabMono 256 && globalOK h C.findVal wt && C.checkRange13 h wt lam lo hi chunks

end CS31aCert
