import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1177 = cert_data/n13/h13c.vec.part1177, entries 113544003584 .. 113640472575, chunks 27071 .. 27093
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1177 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1177" 385875968 16777216

end CS31aData.N13
