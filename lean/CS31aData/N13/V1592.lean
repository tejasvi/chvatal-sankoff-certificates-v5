import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1592 = cert_data/n13/h13c.vec.part1592, entries 153578635264 .. 153675104255, chunks 36616 .. 36638
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1592 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1592" 385875968 16777216

end CS31aData.N13
