import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 520 = cert_data/n13/h13c.vec.part0520, entries 50163875840 .. 50260344831, chunks 11960 .. 11982
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v520 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0520" 385875968 16777216

end CS31aData.N13
