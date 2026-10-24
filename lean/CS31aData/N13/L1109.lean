import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1109 = cert_data/n13/h13c.low.part1109, entries 144195977216 .. 144326000639, chunks 34379 .. 34409
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1109 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1109" 390070272 12582912

end CS31aData.N13
