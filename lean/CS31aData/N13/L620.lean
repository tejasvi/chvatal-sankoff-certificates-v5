import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 620 = cert_data/n13/h13c.low.part0620, entries 80614522880 .. 80744546303, chunks 19220 .. 19250
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l620 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0620" 390070272 12582912

end CS31aData.N13
