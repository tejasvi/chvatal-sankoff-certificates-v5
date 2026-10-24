import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 273 = cert_data/n13/h13c.low.part0273, entries 35496394752 .. 35626418175, chunks 8463 .. 8493
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l273 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0273" 390070272 12582912

end CS31aData.N13
