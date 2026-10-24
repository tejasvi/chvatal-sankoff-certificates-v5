import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1394 = cert_data/n13/h13c.vec.part1394, entries 134477774848 .. 134574243839, chunks 32062 .. 32084
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1394 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1394" 385875968 16777216

end CS31aData.N13
