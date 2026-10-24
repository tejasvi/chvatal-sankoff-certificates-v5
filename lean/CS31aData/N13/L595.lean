import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 595 = cert_data/n13/h13c.low.part0595, entries 77363937280 .. 77493960703, chunks 18445 .. 18475
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l595 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0595" 390070272 12582912

end CS31aData.N13
