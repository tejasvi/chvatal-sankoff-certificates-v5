/-!
# Bytes ↔ natural numbers (core Lean only, compiled; used at elaboration time to build data literals)
-/

namespace CS31aCert

/-- The natural number with little-endian bytes `b[off], …, b[off+len-1]` (divide and conquer). -/
def natOfBytes (b : ByteArray) (off len : Nat) : Nat :=
  if len ≤ 8 then
    (List.range len).foldr (fun i acc => acc * 256 + (b.get! (off + i)).toNat) 0
  else
    let half := len / 2
    natOfBytes b off half ||| (natOfBytes b (off + half) (len - half) <<< (8 * half))
termination_by len
decreasing_by all_goals omega

end CS31aCert
