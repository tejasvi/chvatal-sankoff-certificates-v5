import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1199 = cert_data/n13/h13c.vec.part1199, entries 115666321408 .. 115762790399, chunks 27577 .. 27599
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1199 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1199" 385875968 16777216

end CS31aData.N13
