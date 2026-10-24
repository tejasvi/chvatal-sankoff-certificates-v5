import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1057 = cert_data/n13/h13c.vec.part1057, entries 101967724544 .. 102064193535, chunks 24311 .. 24333
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1057 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1057" 385875968 16777216

end CS31aData.N13
