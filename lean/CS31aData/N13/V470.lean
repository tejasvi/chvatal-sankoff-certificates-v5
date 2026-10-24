import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 470 = cert_data/n13/h13c.vec.part0470, entries 45340426240 .. 45436895231, chunks 10810 .. 10832
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v470 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0470" 385875968 16777216

end CS31aData.N13
