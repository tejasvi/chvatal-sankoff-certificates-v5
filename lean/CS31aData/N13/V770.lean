import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 770 = cert_data/n13/h13c.vec.part0770, entries 74281123840 .. 74377592831, chunks 17710 .. 17732
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v770 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0770" 385875968 16777216

end CS31aData.N13
