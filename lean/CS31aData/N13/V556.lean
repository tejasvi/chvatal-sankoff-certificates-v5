import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 556 = cert_data/n13/h13c.vec.part0556, entries 53636759552 .. 53733228543, chunks 12788 .. 12810
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v556 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0556" 385875968 16777216

end CS31aData.N13
