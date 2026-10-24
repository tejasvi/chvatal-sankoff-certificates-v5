import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 297 = cert_data/n13/h13c.vec.part0297, entries 28651290624 .. 28747759615, chunks 6831 .. 6853
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v297 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0297" 385875968 16777216

end CS31aData.N13
