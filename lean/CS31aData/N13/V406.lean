import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 406 = cert_data/n13/h13c.vec.part0406, entries 39166410752 .. 39262879743, chunks 9338 .. 9360
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v406 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0406" 385875968 16777216

end CS31aData.N13
