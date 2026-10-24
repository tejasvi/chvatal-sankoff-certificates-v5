import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 531 = cert_data/n13/h13c.vec.part0531, entries 51225034752 .. 51321503743, chunks 12213 .. 12235
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v531 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0531" 385875968 16777216

end CS31aData.N13
