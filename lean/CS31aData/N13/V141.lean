import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 141 = cert_data/n13/h13c.vec.part0141, entries 13602127872 .. 13698596863, chunks 3243 .. 3265
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v141 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0141" 385875968 16777216

end CS31aData.N13
