import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 497 = cert_data/n13/h13c.vec.part0497, entries 47945089024 .. 48041558015, chunks 11431 .. 11453
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v497 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0497" 385875968 16777216

end CS31aData.N13
