import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1081 = cert_data/n13/h13c.vec.part1081, entries 104282980352 .. 104379449343, chunks 24863 .. 24885
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1081 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1081" 385875968 16777216

end CS31aData.N13
