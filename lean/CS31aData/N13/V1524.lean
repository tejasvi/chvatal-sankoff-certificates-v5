import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1524 = cert_data/n13/h13c.vec.part1524, entries 147018743808 .. 147115212799, chunks 35052 .. 35074
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1524 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1524" 385875968 16777216

end CS31aData.N13
