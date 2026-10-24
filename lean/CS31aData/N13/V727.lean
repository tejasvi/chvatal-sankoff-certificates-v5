import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 727 = cert_data/n13/h13c.vec.part0727, entries 70132957184 .. 70229426175, chunks 16721 .. 16743
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v727 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0727" 385875968 16777216

end CS31aData.N13
