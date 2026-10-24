import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1179 = cert_data/n13/h13c.low.part1179, entries 153297616896 .. 153427640319, chunks 36549 .. 36579
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1179 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1179" 390070272 12582912

end CS31aData.N13
