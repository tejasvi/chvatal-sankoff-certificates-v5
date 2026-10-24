import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1507 = cert_data/n13/h13c.vec.part1507, entries 145378770944 .. 145475239935, chunks 34661 .. 34683
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1507 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1507" 385875968 16777216

end CS31aData.N13
