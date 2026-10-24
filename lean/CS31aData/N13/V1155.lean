import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1155 = cert_data/n13/h13c.vec.part1155, entries 111421685760 .. 111518154751, chunks 26565 .. 26587
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1155 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1155" 385875968 16777216

end CS31aData.N13
