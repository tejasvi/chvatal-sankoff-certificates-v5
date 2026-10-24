import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 924 = cert_data/n13/h13c.vec.part0924, entries 89137348608 .. 89233817599, chunks 21252 .. 21274
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v924 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0924" 385875968 16777216

end CS31aData.N13
