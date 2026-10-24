import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 895 = cert_data/n13/h13c.vec.part0895, entries 86339747840 .. 86436216831, chunks 20585 .. 20607
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v895 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0895" 385875968 16777216

end CS31aData.N13
