import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1379 = cert_data/n13/h13c.vec.part1379, entries 133030739968 .. 133127208959, chunks 31717 .. 31739
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1379 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1379" 385875968 16777216

end CS31aData.N13
