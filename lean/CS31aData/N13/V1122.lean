import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1122 = cert_data/n13/h13c.vec.part1122, entries 108238209024 .. 108334678015, chunks 25806 .. 25828
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1122 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1122" 385875968 16777216

end CS31aData.N13
