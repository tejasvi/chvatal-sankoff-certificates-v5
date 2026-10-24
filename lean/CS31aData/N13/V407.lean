import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 407 = cert_data/n13/h13c.vec.part0407, entries 39262879744 .. 39359348735, chunks 9361 .. 9383
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v407 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0407" 385875968 16777216

end CS31aData.N13
