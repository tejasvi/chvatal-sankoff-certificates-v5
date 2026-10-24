import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1499 = cert_data/n13/h13c.vec.part1499, entries 144607019008 .. 144703487999, chunks 34477 .. 34499
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1499 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1499" 385875968 16777216

end CS31aData.N13
