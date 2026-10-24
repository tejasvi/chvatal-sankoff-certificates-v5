import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 333 = cert_data/n13/h13c.vec.part0333, entries 32124174336 .. 32220643327, chunks 7659 .. 7681
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v333 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0333" 385875968 16777216

end CS31aData.N13
