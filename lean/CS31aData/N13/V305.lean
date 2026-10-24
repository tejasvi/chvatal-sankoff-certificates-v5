import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 305 = cert_data/n13/h13c.vec.part0305, entries 29423042560 .. 29519511551, chunks 7015 .. 7037
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v305 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0305" 385875968 16777216

end CS31aData.N13
