import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 153 = cert_data/n13/h13c.vec.part0153, entries 14759755776 .. 14856224767, chunks 3519 .. 3541
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v153 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0153" 385875968 16777216

end CS31aData.N13
