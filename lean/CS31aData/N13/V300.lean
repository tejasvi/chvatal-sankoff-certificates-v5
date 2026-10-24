import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 300 = cert_data/n13/h13c.vec.part0300, entries 28940697600 .. 29037166591, chunks 6900 .. 6922
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v300 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0300" 385875968 16777216

end CS31aData.N13
