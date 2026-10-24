import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 917 = cert_data/n13/h13c.vec.part0917, entries 88462065664 .. 88558534655, chunks 21091 .. 21113
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v917 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0917" 385875968 16777216

end CS31aData.N13
