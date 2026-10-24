import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 177 = cert_data/n13/h13c.low.part0177, entries 23014146048 .. 23144169471, chunks 5487 .. 5517
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l177 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0177" 390070272 12582912

end CS31aData.N13
