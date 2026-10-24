import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 81 = cert_data/n13/h13c.vec.part0081, entries 7813988352 .. 7910457343, chunks 1863 .. 1885
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v81 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0081" 385875968 16777216

end CS31aData.N13
