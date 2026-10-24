import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1040 = cert_data/n13/h13c.low.part1040, entries 135224360960 .. 135354384383, chunks 32240 .. 32270
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1040 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1040" 390070272 12582912

end CS31aData.N13
