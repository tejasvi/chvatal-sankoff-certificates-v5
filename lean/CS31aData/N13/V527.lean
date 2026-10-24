import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 527 = cert_data/n13/h13c.vec.part0527, entries 50839158784 .. 50935627775, chunks 12121 .. 12143
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v527 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0527" 385875968 16777216

end CS31aData.N13
