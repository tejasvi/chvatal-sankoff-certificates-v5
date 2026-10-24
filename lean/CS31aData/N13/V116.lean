import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 116 = cert_data/n13/h13c.vec.part0116, entries 11190403072 .. 11286872063, chunks 2668 .. 2690
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v116 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0116" 385875968 16777216

end CS31aData.N13
