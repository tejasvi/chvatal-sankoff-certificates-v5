import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 728 = cert_data/n13/h13c.vec.part0728, entries 70229426176 .. 70325895167, chunks 16744 .. 16766
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v728 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0728" 385875968 16777216

end CS31aData.N13
