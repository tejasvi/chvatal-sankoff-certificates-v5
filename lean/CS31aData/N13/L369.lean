import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 369 = cert_data/n13/h13c.low.part0369, entries 47978643456 .. 48108666879, chunks 11439 .. 11469
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l369 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0369" 390070272 12582912

end CS31aData.N13
