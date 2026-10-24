import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1401 = cert_data/n13/h13c.vec.part1401, entries 135153057792 .. 135249526783, chunks 32223 .. 32245
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1401 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1401" 385875968 16777216

end CS31aData.N13
