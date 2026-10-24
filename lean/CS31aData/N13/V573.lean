import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 573 = cert_data/n13/h13c.vec.part0573, entries 55276732416 .. 55373201407, chunks 13179 .. 13201
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v573 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0573" 385875968 16777216

end CS31aData.N13
