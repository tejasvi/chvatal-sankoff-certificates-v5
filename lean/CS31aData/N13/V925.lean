import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 925 = cert_data/n13/h13c.vec.part0925, entries 89233817600 .. 89330286591, chunks 21275 .. 21297
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v925 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0925" 385875968 16777216

end CS31aData.N13
