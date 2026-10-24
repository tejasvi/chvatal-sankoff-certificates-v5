import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 345 = cert_data/n13/h13c.low.part0345, entries 44858081280 .. 44988104703, chunks 10695 .. 10725
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l345 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0345" 390070272 12582912

end CS31aData.N13
