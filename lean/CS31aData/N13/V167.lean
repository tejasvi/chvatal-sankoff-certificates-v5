import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 167 = cert_data/n13/h13c.vec.part0167, entries 16110321664 .. 16206790655, chunks 3841 .. 3863
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v167 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0167" 385875968 16777216

end CS31aData.N13
