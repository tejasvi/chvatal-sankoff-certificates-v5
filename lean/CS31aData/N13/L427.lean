import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 427 = cert_data/n13/h13c.low.part0427, entries 55520002048 .. 55650025471, chunks 13237 .. 13267
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l427 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0427" 390070272 12582912

end CS31aData.N13
