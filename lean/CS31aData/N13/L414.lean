import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 414 = cert_data/n13/h13c.low.part0414, entries 53829697536 .. 53959720959, chunks 12834 .. 12864
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l414 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0414" 390070272 12582912

end CS31aData.N13
