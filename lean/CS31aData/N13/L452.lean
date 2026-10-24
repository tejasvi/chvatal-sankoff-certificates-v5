import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 452 = cert_data/n13/h13c.low.part0452, entries 58770587648 .. 58900611071, chunks 14012 .. 14042
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l452 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0452" 390070272 12582912

end CS31aData.N13
