import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 706 = cert_data/n13/h13c.vec.part0706, entries 68107108352 .. 68203577343, chunks 16238 .. 16260
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v706 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0706" 385875968 16777216

end CS31aData.N13
