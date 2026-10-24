import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1620 = cert_data/n13/h13c.vec.part1620, entries 156279767040 .. 156376236031, chunks 37260 .. 37282
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1620 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1620" 385875968 16777216

end CS31aData.N13
