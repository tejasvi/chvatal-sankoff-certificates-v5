import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 960 = cert_data/n13/h13c.vec.part0960, entries 92610232320 .. 92706701311, chunks 22080 .. 22102
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v960 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0960" 385875968 16777216

end CS31aData.N13
