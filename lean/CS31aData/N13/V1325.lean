import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1325 = cert_data/n13/h13c.vec.part1325, entries 127821414400 .. 127917883391, chunks 30475 .. 30497
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1325 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1325" 385875968 16777216

end CS31aData.N13
