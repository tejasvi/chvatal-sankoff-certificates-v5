import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1610 = cert_data/n13/h13c.vec.part1610, entries 155315077120 .. 155411546111, chunks 37030 .. 37052
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1610 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1610" 385875968 16777216

end CS31aData.N13
