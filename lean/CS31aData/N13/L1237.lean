import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1237 = cert_data/n13/h13c.low.part1237, entries 160838975488 .. 160968998911, chunks 38347 .. 38377
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1237 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1237" 390070272 12582912

end CS31aData.N13
