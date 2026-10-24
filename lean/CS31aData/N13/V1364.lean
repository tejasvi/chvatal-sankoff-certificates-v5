import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1364 = cert_data/n13/h13c.vec.part1364, entries 131583705088 .. 131680174079, chunks 31372 .. 31394
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1364 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1364" 385875968 16777216

end CS31aData.N13
