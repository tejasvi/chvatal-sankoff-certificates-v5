import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 67 = cert_data/n13/h13c.vec.part0067, entries 6463422464 .. 6559891455, chunks 1541 .. 1563
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v67 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0067" 385875968 16777216

end CS31aData.N13
