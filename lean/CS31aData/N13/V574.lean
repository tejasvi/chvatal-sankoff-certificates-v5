import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 574 = cert_data/n13/h13c.vec.part0574, entries 55373201408 .. 55469670399, chunks 13202 .. 13224
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v574 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0574" 385875968 16777216

end CS31aData.N13
