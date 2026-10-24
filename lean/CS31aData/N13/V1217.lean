import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1217 = cert_data/n13/h13c.vec.part1217, entries 117402763264 .. 117499232255, chunks 27991 .. 28013
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1217 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1217" 385875968 16777216

end CS31aData.N13
