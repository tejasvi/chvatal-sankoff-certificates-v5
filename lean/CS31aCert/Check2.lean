import CS31aCert.KStep
import CS31aCert.Check

/-!
# Native checker for large certificates (core Lean only, compiled)

Differences from `checkCert`:
* the literal chunks are decoded in parallel tasks and then concatenated into one byte array per file;
* lookups start from a radix table (`tab[b]` = first index whose key is `≥ b·2^s`, built by one pass over the keys) and
  finish with a binary search inside the bucket; the answer is re-checked (`key j = t`), so soundness depends neither
  on the table nor on the order of the keys.
Rows use `rowOK` (`stepCode`).
-/

namespace CS31aCert

/-- Little-endian `UInt64` number `i` of a byte array, assembled in `UInt64` arithmetic (as a natural number). -/
@[inline] def getW (b : ByteArray) (i : Nat) : Nat :=
  let o := 8 * i
  ((b.get! o).toUInt64 ||| ((b.get! (o + 1)).toUInt64 <<< 8) ||| ((b.get! (o + 2)).toUInt64 <<< 16) |||
    ((b.get! (o + 3)).toUInt64 <<< 24) ||| ((b.get! (o + 4)).toUInt64 <<< 32) ||| ((b.get! (o + 5)).toUInt64 <<< 40) |||
    ((b.get! (o + 6)).toUInt64 <<< 48) ||| ((b.get! (o + 7)).toUInt64 <<< 56)).toNat

/-- Binary search for `t` among the keys `[lo, hi)` (fuel-bounded); the answer is verified by the caller. -/
def bsearchR (keys : ByteArray) (t : Nat) : Nat → Nat → Nat → Nat
  | 0, lo, _ => lo
  | fuel + 1, lo, hi =>
    if hi ≤ lo + 1 then lo
    else
      let mid := (lo + hi) / 2
      if getW keys mid ≤ t then bsearchR keys t fuel mid hi else bsearchR keys t fuel lo mid

/-- One pass over the keys: `tab[b]` for `b = 0..nb` (fuel-bounded). -/
def radixScan (keys : ByteArray) (n s nb : Nat) : Nat → Nat → Nat → Array Nat → Array Nat
  | 0, _, _, tab => tab
  | fuel + 1, b, i, tab =>
    if nb < b then tab
    else if i < n && getW keys i < b <<< s then radixScan keys n s nb fuel b (i + 1) tab
    else radixScan keys n s nb fuel (b + 1) i (tab.push i)

/-- First index in `[lo, hi)` whose key is `≥ x` (`hi` if none; fuel-bounded binary search). -/
def lowerBound (keys : ByteArray) (x : Nat) : Nat → Nat → Nat → Nat
  | 0, lo, _ => lo
  | fuel + 1, lo, hi =>
    if lo < hi then
      let mid := (lo + hi) / 2
      if getW keys mid < x then lowerBound keys x fuel (mid + 1) hi else lowerBound keys x fuel lo mid
    else lo

/-- The radix table of the keys (buckets of `2^s` codes, `nb + 1` entries), built by `parts` parallel scans. -/
def buildRadix (keys : ByteArray) (n s nb : Nat) : Array Nat :=
  let parts := 256
  let per := (nb + parts) / parts
  let tasks := (List.range parts).map fun p => Task.spawn fun _ =>
    let b0 := p * per
    let bmax := min nb (b0 + per - 1)
    if bmax < b0 then #[] else
      radixScan keys n s bmax (n + per + 2) b0 (lowerBound keys (b0 <<< s) 64 0 n) (Array.mkEmpty per)
  tasks.foldl (fun acc t => acc ++ t.get) (Array.mkEmpty (nb + 1))

/-- The index of `t` among the keys, if present (checked equality). -/
@[inline] def findR (keys : ByteArray) (n s : Nat) (tab : Array Nat) (t : Nat) : Option Nat :=
  let b := t >>> s
  let j := bsearchR keys t 64 (tab.getD b n) (tab.getD (b + 1) n)
  if j < n && getW keys j == t then some j else none

/-- The lookup: the value bits of a listed code. -/
@[inline] def findValR (keys vec : ByteArray) (n s : Nat) (tab : Array Nat) (t : Nat) : Option Nat :=
  match findR keys n s tab t with
  | none => none
  | some j => some (getW vec j)

/-- Rows `lo, lo+1, …, lo+cnt-1`. -/
def rowsOK2 (h : Nat) (keys vec : ByteArray) (n s : Nat) (tab : Array Nat) (wt : List Nat) (lam : Nat) :
    Nat → Nat → Bool
  | _, 0 => true
  | lo, cnt + 1 =>
    rowOK h (findValR keys vec n s tab) wt lam (getW keys lo) (getW vec lo) &&
    rowsOK2 h keys vec n s tab wt lam (lo + 1) cnt

/-- The whole check, with the rows split into `chunks` parallel tasks. -/
def checkCert2 (h : Nat) (keys vec : ByteArray) (n s nb : Nat) (wt : List Nat) (lam chunks : Nat) : Bool :=
  let tab := buildRadix keys n s nb
  let size := (n + chunks - 1) / max chunks 1
  let tasks := (List.range chunks).map fun c =>
    Task.spawn (prio := .dedicated) fun _ =>
      rowsOK2 h keys vec n s tab wt lam (c * size) (min size (n - min n (c * size)))
  keys.size == 8 * n && vec.size == 8 * n && Nat.ble n (chunks * size) &&
    globalOK h (findValR keys vec n s tab) wt && tasks.all (·.get)

/-- Rows `lo ≤ i < hi` only (for splitting one certificate over several machines), `chunks` parallel tasks. -/
def checkRange2 (h : Nat) (keys vec : ByteArray) (n s : Nat) (tab : Array Nat) (wt : List Nat) (lam lo hi chunks : Nat) :
    Bool :=
  let cnt := hi - lo
  let size := (cnt + chunks - 1) / max chunks 1
  let tasks := (List.range chunks).map fun c =>
    Task.spawn (prio := .dedicated) fun _ =>
      rowsOK2 h keys vec n s tab wt lam (lo + c * size) (min size (cnt - min cnt (c * size)))
  Nat.ble cnt (chunks * size) && tasks.all (·.get)

/-- The concatenation of byte chunks given as (literal, byte length), each chunk decoded in its own task. -/
def bytesOfChunksPar (cs : List (Nat × Nat)) : ByteArray :=
  let parts := (cs.map fun c => Task.spawn fun _ => natToBytes c.1 c.2).map Task.get
  parts.foldl (· ++ ·) (ByteArray.emptyWithCapacity (cs.foldl (· + ·.2) 0))

/-- The check on chunked literal data. -/
def checkCertChunks2 (h : Nat) (keyCs vecCs : List (Nat × Nat)) (n s nb : Nat) (wt : List Nat) (lam chunks : Nat) :
    Bool :=
  checkCert2 h (bytesOfChunksPar keyCs) (bytesOfChunksPar vecCs) n s nb wt lam chunks

/-- One machine's share of a certificate given as literal chunks: decode, radix table, the global conditions and the
rows `lo ≤ i < hi`. Several such checks whose ranges cover `[0, n)` give the whole certificate
(`CS31a.checkCertChunksR2_sound3`). -/
def checkCertChunksR2 (h : Nat) (keyCs vecCs : List (Nat × Nat)) (n s nb : Nat) (wt : List Nat) (lam lo hi chunks : Nat) :
    Bool :=
  let keys := bytesOfChunksPar keyCs
  let vec := bytesOfChunksPar vecCs
  let tab := buildRadix keys n s nb
  keys.size == 8 * n && vec.size == 8 * n && globalOK h (findValR keys vec n s tab) wt &&
    checkRange2 h keys vec n s tab wt lam lo hi chunks

end CS31aCert
