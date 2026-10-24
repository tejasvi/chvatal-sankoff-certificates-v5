import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 666 = cert_data/n13/h13c.vec.part0666, entries 64248348672 .. 64344817663, chunks 15318 .. 15340
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v666 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0666" 385875968 16777216

end CS31aData.N13
