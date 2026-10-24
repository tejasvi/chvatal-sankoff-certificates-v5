import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1113 = cert_data/n13/h13c.vec.part1113, entries 107369988096 .. 107466457087, chunks 25599 .. 25621
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1113 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1113" 385875968 16777216

end CS31aData.N13
