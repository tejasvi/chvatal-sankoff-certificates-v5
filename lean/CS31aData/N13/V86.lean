import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 86 = cert_data/n13/h13c.vec.part0086, entries 8296333312 .. 8392802303, chunks 1978 .. 2000
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v86 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0086" 385875968 16777216

end CS31aData.N13
