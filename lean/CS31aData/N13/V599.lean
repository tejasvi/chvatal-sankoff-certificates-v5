import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 599 = cert_data/n13/h13c.vec.part0599, entries 57784926208 .. 57881395199, chunks 13777 .. 13799
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v599 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0599" 385875968 16777216

end CS31aData.N13
