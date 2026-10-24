import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 542 = cert_data/n13/h13c.low.part0542, entries 70472695808 .. 70602719231, chunks 16802 .. 16832
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l542 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0542" 390070272 12582912

end CS31aData.N13
