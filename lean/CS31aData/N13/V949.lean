import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 949 = cert_data/n13/h13c.vec.part0949, entries 91549073408 .. 91645542399, chunks 21827 .. 21849
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v949 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0949" 385875968 16777216

end CS31aData.N13
