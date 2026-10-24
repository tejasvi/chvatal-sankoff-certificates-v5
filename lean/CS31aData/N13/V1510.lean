import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1510 = cert_data/n13/h13c.vec.part1510, entries 145668177920 .. 145764646911, chunks 34730 .. 34752
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1510 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1510" 385875968 16777216

end CS31aData.N13
