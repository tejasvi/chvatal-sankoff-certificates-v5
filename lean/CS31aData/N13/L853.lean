import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 853 = cert_data/n13/h13c.low.part0853, entries 110909980672 .. 111040004095, chunks 26443 .. 26473
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l853 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0853" 390070272 12582912

end CS31aData.N13
