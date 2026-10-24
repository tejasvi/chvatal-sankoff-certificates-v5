import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 926 = cert_data/n13/h13c.vec.part0926, entries 89330286592 .. 89426755583, chunks 21298 .. 21320
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v926 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0926" 385875968 16777216

end CS31aData.N13
