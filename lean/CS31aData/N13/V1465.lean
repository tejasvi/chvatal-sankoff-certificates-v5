import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1465 = cert_data/n13/h13c.vec.part1465, entries 141327073280 .. 141423542271, chunks 33695 .. 33717
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1465 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1465" 385875968 16777216

end CS31aData.N13
