import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1457 = cert_data/n13/h13c.vec.part1457, entries 140555321344 .. 140651790335, chunks 33511 .. 33533
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1457 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1457" 385875968 16777216

end CS31aData.N13
