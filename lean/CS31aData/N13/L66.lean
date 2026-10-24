import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 66 = cert_data/n13/h13c.low.part0066, entries 8581545984 .. 8711569407, chunks 2046 .. 2076
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l66 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0066" 390070272 12582912

end CS31aData.N13
