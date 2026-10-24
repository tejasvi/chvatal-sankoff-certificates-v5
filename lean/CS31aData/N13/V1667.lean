import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1667 = cert_data/n13/h13c.vec.part1667, entries 160813809664 .. 160910278655, chunks 38341 .. 38363
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1667 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1667" 385875968 16777216

end CS31aData.N13
