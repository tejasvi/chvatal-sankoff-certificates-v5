import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1614 = cert_data/n13/h13c.vec.part1614, entries 155700953088 .. 155797422079, chunks 37122 .. 37144
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1614 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1614" 385875968 16777216

end CS31aData.N13
