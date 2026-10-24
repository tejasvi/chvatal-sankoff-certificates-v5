import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 176 = cert_data/n13/h13c.vec.part0176, entries 16978542592 .. 17075011583, chunks 4048 .. 4070
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v176 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0176" 385875968 16777216

end CS31aData.N13
