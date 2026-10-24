import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 136 = cert_data/n13/h13c.vec.part0136, entries 13119782912 .. 13216251903, chunks 3128 .. 3150
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v136 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0136" 385875968 16777216

end CS31aData.N13
