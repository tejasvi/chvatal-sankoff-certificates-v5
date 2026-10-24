import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 484 = cert_data/n13/h13c.vec.part0484, entries 46690992128 .. 46787461119, chunks 11132 .. 11154
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v484 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0484" 385875968 16777216

end CS31aData.N13
