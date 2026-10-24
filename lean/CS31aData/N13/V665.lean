import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 665 = cert_data/n13/h13c.vec.part0665, entries 64151879680 .. 64248348671, chunks 15295 .. 15317
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v665 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0665" 385875968 16777216

end CS31aData.N13
