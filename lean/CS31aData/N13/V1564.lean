import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1564 = cert_data/n13/h13c.vec.part1564, entries 150877503488 .. 150973972479, chunks 35972 .. 35994
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1564 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1564" 385875968 16777216

end CS31aData.N13
