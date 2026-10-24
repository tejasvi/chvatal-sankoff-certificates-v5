import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1013 = cert_data/n13/h13c.low.part1013, entries 131713728512 .. 131843751935, chunks 31403 .. 31433
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1013 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1013" 390070272 12582912

end CS31aData.N13
