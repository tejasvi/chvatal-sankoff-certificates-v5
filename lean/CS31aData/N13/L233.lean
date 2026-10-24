import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 233 = cert_data/n13/h13c.low.part0233, entries 30295457792 .. 30425481215, chunks 7223 .. 7253
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l233 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0233" 390070272 12582912

end CS31aData.N13
