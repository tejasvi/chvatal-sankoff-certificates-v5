import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 822 = cert_data/n13/h13c.vec.part0822, entries 79297511424 .. 79393980415, chunks 18906 .. 18928
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v822 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0822" 385875968 16777216

end CS31aData.N13
