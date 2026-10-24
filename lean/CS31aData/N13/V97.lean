import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 97 = cert_data/n13/h13c.vec.part0097, entries 9357492224 .. 9453961215, chunks 2231 .. 2253
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v97 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0097" 385875968 16777216

end CS31aData.N13
