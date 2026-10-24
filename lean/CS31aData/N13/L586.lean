import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 586 = cert_data/n13/h13c.low.part0586, entries 76193726464 .. 76323749887, chunks 18166 .. 18196
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l586 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0586" 390070272 12582912

end CS31aData.N13
