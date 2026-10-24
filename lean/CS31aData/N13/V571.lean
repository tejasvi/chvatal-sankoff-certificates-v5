import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 571 = cert_data/n13/h13c.vec.part0571, entries 55083794432 .. 55180263423, chunks 13133 .. 13155
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v571 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0571" 385875968 16777216

end CS31aData.N13
