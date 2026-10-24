import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 418 = cert_data/n13/h13c.vec.part0418, entries 40324038656 .. 40420507647, chunks 9614 .. 9636
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v418 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0418" 385875968 16777216

end CS31aData.N13
