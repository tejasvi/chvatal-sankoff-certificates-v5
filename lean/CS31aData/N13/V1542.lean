import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1542 = cert_data/n13/h13c.vec.part1542, entries 148755185664 .. 148851654655, chunks 35466 .. 35488
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1542 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1542" 385875968 16777216

end CS31aData.N13
