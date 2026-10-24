import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1096 = cert_data/n13/h13c.vec.part1096, entries 105730015232 .. 105826484223, chunks 25208 .. 25230
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1096 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1096" 385875968 16777216

end CS31aData.N13
