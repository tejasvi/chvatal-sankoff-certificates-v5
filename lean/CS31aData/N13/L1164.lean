import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1164 = cert_data/n13/h13c.low.part1164, entries 151347265536 .. 151477288959, chunks 36084 .. 36114
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1164 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1164" 390070272 12582912

end CS31aData.N13
