import CS31aCert.Row

/-!
# Native checker for a Collatz–Wielandt certificate of `M_h` (core Lean only, compiled)

Data: `keys` (N little-endian `UInt64` state codes), `vec` (N little-endian IEEE doubles, the vector `v`),
integer weights `wt[k] ≥ 2^64 w_z(k)` (`k = |l| < h`) and `lam` (the claimed `Λ`, so `λ = Λ / 2^64`).

`checkCert` verifies, for every index `i < N`:
* `key i < 2^(4h)`, `find (key i) = some i` (so the list has no duplicates and the lookup is consistent);
* `vec i` is a positive normal double (sign 0, biased exponent in `1..2046`);
* for every input `(c,l)` accepted at `key i`, its reduced successor `t` is listed (`find t = some j`);
* `Σ_{accepted} wt[|l|] · val(vec j) ≤ lam · val(vec i)` exactly, where `val u = (2^52 + u mod 2^52) · 2^(e - 1075)`,
  `e = ⌊u / 2^52⌋ mod 2^11`; both sides are scaled by `2^(1075 - e_min)` with `e_min` the least exponent in the row.
and that the start state is listed. `find` is a binary search whose answer is re-checked (`key j = t`), so soundness
does not depend on the order of the keys. The rows are split into chunks checked in parallel tasks.
-/

namespace CS31aCert

/-- Little-endian `UInt64` number `i` of a byte array (as a natural number). -/
@[inline] def getU64 (b : ByteArray) (i : Nat) : Nat :=
  let o := 8 * i
  (b.get! o).toNat ||| ((b.get! (o + 1)).toNat <<< 8) ||| ((b.get! (o + 2)).toNat <<< 16) |||
  ((b.get! (o + 3)).toNat <<< 24) ||| ((b.get! (o + 4)).toNat <<< 32) ||| ((b.get! (o + 5)).toNat <<< 40) |||
  ((b.get! (o + 6)).toNat <<< 48) ||| ((b.get! (o + 7)).toNat <<< 56)

/-- Binary search for `t` among `keys[lo..hi)` (fuel-bounded); the answer is verified by the caller. -/
def bsearch (keys : ByteArray) (t : Nat) : Nat → Nat → Nat → Nat
  | 0, lo, _ => lo
  | fuel + 1, lo, hi =>
    if hi ≤ lo + 1 then lo
    else
      let mid := (lo + hi) / 2
      if getU64 keys mid ≤ t then bsearch keys t fuel mid hi else bsearch keys t fuel lo mid

/-- The index of `t` in `keys` (N entries), if present (checked equality). -/
def find (keys : ByteArray) (n t : Nat) : Option Nat :=
  if n = 0 then none
  else
    let j := bsearch keys t 64 0 n
    if j < n ∧ getU64 keys j = t then some j else none

/-- The lookup in the byte arrays: the value bits of a listed code. -/
@[inline] def findVal (keys vec : ByteArray) (n t : Nat) : Option Nat :=
  match find keys n t with
  | none => none
  | some j => some (getU64 vec j)

/-- Rows `lo, lo+1, …, lo+cnt-1` (structural recursion on the count). -/
def rowsOK (h : Nat) (keys vec : ByteArray) (n : Nat) (wt : Array Nat) (lam : Nat) : Nat → Nat → Bool
  | _, 0 => true
  | lo, cnt + 1 =>
    rowOK h (findVal keys vec n) wt.toList lam (getU64 keys lo) (getU64 vec lo) &&
    rowsOK h keys vec n wt lam (lo + 1) cnt

/-- The whole check, with the rows split into `chunks` parallel tasks. -/
def checkCert (h : Nat) (keys vec : ByteArray) (n : Nat) (wt : Array Nat) (lam chunks : Nat) : Bool :=
  let size := (n + chunks - 1) / max chunks 1
  let tasks := (List.range chunks).map fun c =>
    Task.spawn (prio := .dedicated) fun _ =>
      rowsOK h keys vec n wt lam (c * size) (min size (n - min n (c * size)))
  keys.size == 8 * n && vec.size == 8 * n && Nat.ble n (chunks * size) &&
    globalOK h (findVal keys vec n) wt.toList && tasks.all (·.get)

/-- The bytes of `m` (little endian), exactly `len` of them (divide and conquer). -/
def natToBytes (m len : Nat) : ByteArray :=
  go m len (ByteArray.emptyWithCapacity len)
where
  go (m len : Nat) (acc : ByteArray) : ByteArray :=
    if len ≤ 8 then
      (List.range len).foldl (fun a i => a.push ((m >>> (8 * i)) % 256).toUInt8) acc
    else
      let half := len / 2
      go (m >>> (8 * half)) (len - half) (go (m % 2 ^ (8 * half)) half acc)
  termination_by len
  decreasing_by all_goals omega

/-- The check on literal data: `keysN`, `vecN` are the little-endian byte strings of the two files as numbers. -/
def checkCertNat (h : Nat) (keysN vecN n : Nat) (wt : List Nat) (lam chunks : Nat) : Bool :=
  checkCert h (natToBytes keysN (8 * n)) (natToBytes vecN (8 * n)) n wt.toArray lam chunks

/-- The concatenation of byte chunks given as (literal, byte length). -/
def bytesOfChunks (cs : List (Nat × Nat)) : ByteArray :=
  cs.foldl (fun acc c => natToBytes.go c.1 c.2 acc) (ByteArray.emptyWithCapacity (cs.foldl (· + ·.2) 0))

/-- The check on chunked literal data (each literal below the kernel's numeral size limit). -/
def checkCertChunks (h : Nat) (keyCs vecCs : List (Nat × Nat)) (n : Nat) (wt : List Nat) (lam chunks : Nat) : Bool :=
  checkCert h (bytesOfChunks keyCs) (bytesOfChunks vecCs) n wt.toArray lam chunks

end CS31aCert
