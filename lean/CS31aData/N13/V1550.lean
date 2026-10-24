import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1550 = cert_data/n13/h13c.vec.part1550, entries 149526937600 .. 149623406591, chunks 35650 .. 35672
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1550 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1550" 385875968 16777216

end CS31aData.N13
