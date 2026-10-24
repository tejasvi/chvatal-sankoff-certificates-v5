import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1073 = cert_data/n13/h13c.vec.part1073, entries 103511228416 .. 103607697407, chunks 24679 .. 24701
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1073 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1073" 385875968 16777216

end CS31aData.N13
