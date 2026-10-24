import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 234 = cert_data/n13/h13c.low.part0234, entries 30425481216 .. 30555504639, chunks 7254 .. 7284
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l234 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0234" 390070272 12582912

end CS31aData.N13
