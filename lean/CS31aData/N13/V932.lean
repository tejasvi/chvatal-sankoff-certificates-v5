import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 932 = cert_data/n13/h13c.vec.part0932, entries 89909100544 .. 90005569535, chunks 21436 .. 21458
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v932 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0932" 385875968 16777216

end CS31aData.N13
