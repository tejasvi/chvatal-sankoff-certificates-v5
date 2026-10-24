import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 643 = cert_data/n13/h13c.vec.part0643, entries 62029561856 .. 62126030847, chunks 14789 .. 14811
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v643 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0643" 385875968 16777216

end CS31aData.N13
