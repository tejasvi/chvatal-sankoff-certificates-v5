import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1436 = cert_data/n13/h13c.vec.part1436, entries 138529472512 .. 138625941503, chunks 33028 .. 33050
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1436 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1436" 385875968 16777216

end CS31aData.N13
