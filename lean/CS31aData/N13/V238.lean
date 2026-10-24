import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 238 = cert_data/n13/h13c.vec.part0238, entries 22959620096 .. 23056089087, chunks 5474 .. 5496
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v238 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0238" 385875968 16777216

end CS31aData.N13
