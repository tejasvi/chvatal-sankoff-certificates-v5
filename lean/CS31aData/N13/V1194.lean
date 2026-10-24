import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1194 = cert_data/n13/h13c.vec.part1194, entries 115183976448 .. 115280445439, chunks 27462 .. 27484
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1194 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1194" 385875968 16777216

end CS31aData.N13
