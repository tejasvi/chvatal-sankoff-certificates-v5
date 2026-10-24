import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 431 = cert_data/n13/h13c.vec.part0431, entries 41578135552 .. 41674604543, chunks 9913 .. 9935
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v431 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0431" 385875968 16777216

end CS31aData.N13
