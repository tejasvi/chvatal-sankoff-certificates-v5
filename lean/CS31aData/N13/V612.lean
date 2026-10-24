import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 612 = cert_data/n13/h13c.vec.part0612, entries 59039023104 .. 59135492095, chunks 14076 .. 14098
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v612 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0612" 385875968 16777216

end CS31aData.N13
