import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1005 = cert_data/n13/h13c.low.part1005, entries 130673541120 .. 130803564543, chunks 31155 .. 31185
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1005 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1005" 390070272 12582912

end CS31aData.N13
