import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1238 = cert_data/n13/h13c.vec.part1238, entries 119428612096 .. 119525081087, chunks 28474 .. 28496
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1238 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1238" 385875968 16777216

end CS31aData.N13
