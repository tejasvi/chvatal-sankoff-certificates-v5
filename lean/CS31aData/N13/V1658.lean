import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1658 = cert_data/n13/h13c.vec.part1658, entries 159945588736 .. 160042057727, chunks 38134 .. 38156
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1658 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1658" 385875968 16777216

end CS31aData.N13
