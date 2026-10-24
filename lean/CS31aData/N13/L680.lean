import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 680 = cert_data/n13/h13c.low.part0680, entries 88415928320 .. 88545951743, chunks 21080 .. 21110
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l680 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0680" 390070272 12582912

end CS31aData.N13
