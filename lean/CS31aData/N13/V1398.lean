import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1398 = cert_data/n13/h13c.vec.part1398, entries 134863650816 .. 134960119807, chunks 32154 .. 32176
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1398 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1398" 385875968 16777216

end CS31aData.N13
