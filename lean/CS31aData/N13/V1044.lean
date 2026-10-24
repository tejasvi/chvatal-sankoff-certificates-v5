import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1044 = cert_data/n13/h13c.vec.part1044, entries 100713627648 .. 100810096639, chunks 24012 .. 24034
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1044 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1044" 385875968 16777216

end CS31aData.N13
