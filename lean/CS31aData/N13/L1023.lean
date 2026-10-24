import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1023 = cert_data/n13/h13c.low.part1023, entries 133013962752 .. 133143986175, chunks 31713 .. 31743
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1023 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1023" 390070272 12582912

end CS31aData.N13
