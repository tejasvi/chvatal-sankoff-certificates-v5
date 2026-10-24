import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 638 = cert_data/n13/h13c.vec.part0638, entries 61547216896 .. 61643685887, chunks 14674 .. 14696
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v638 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0638" 385875968 16777216

end CS31aData.N13
