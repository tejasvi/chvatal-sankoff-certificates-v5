import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 637 = cert_data/n13/h13c.vec.part0637, entries 61450747904 .. 61547216895, chunks 14651 .. 14673
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v637 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0637" 385875968 16777216

end CS31aData.N13
