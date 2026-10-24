import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1598 = cert_data/n13/h13c.vec.part1598, entries 154157449216 .. 154253918207, chunks 36754 .. 36776
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1598 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1598" 385875968 16777216

end CS31aData.N13
