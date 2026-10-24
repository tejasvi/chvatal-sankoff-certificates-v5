import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 784 = cert_data/n13/h13c.vec.part0784, entries 75631689728 .. 75728158719, chunks 18032 .. 18054
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v784 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0784" 385875968 16777216

end CS31aData.N13
