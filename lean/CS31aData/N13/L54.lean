import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 54 = cert_data/n13/h13c.low.part0054, entries 7021264896 .. 7151288319, chunks 1674 .. 1704
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l54 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0054" 390070272 12582912

end CS31aData.N13
