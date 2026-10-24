import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 334 = cert_data/n13/h13c.vec.part0334, entries 32220643328 .. 32317112319, chunks 7682 .. 7704
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v334 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0334" 385875968 16777216

end CS31aData.N13
