import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 677 = cert_data/n13/h13c.vec.part0677, entries 65309507584 .. 65405976575, chunks 15571 .. 15593
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v677 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0677" 385875968 16777216

end CS31aData.N13
