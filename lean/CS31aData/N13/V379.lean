import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 379 = cert_data/n13/h13c.vec.part0379, entries 36561747968 .. 36658216959, chunks 8717 .. 8739
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v379 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0379" 385875968 16777216

end CS31aData.N13
