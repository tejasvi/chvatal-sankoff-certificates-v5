import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 761 = cert_data/n13/h13c.vec.part0761, entries 73412902912 .. 73509371903, chunks 17503 .. 17525
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v761 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0761" 385875968 16777216

end CS31aData.N13
