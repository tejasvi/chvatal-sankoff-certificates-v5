import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 300 = cert_data/n13/h13c.low.part0300, entries 39007027200 .. 39137050623, chunks 9300 .. 9330
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l300 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0300" 390070272 12582912

end CS31aData.N13
