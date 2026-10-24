import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1105 = cert_data/n13/h13c.vec.part1105, entries 106598236160 .. 106694705151, chunks 25415 .. 25437
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1105 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1105" 385875968 16777216

end CS31aData.N13
