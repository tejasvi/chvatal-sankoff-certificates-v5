import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1003 = cert_data/n13/h13c.low.part1003, entries 130413494272 .. 130543517695, chunks 31093 .. 31123
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1003 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1003" 390070272 12582912

end CS31aData.N13
