import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1484 = cert_data/n13/h13c.vec.part1484, entries 143159984128 .. 143256453119, chunks 34132 .. 34154
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1484 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1484" 385875968 16777216

end CS31aData.N13
