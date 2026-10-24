import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1110 = cert_data/n13/h13c.low.part1110, entries 144326000640 .. 144456024063, chunks 34410 .. 34440
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1110 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1110" 390070272 12582912

end CS31aData.N13
