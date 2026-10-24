import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 298 = cert_data/n13/h13c.vec.part0298, entries 28747759616 .. 28844228607, chunks 6854 .. 6876
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v298 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0298" 385875968 16777216

end CS31aData.N13
