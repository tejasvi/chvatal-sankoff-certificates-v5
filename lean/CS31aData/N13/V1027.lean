import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1027 = cert_data/n13/h13c.vec.part1027, entries 99073654784 .. 99170123775, chunks 23621 .. 23643
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1027 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1027" 385875968 16777216

end CS31aData.N13
