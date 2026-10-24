import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1106 = cert_data/n13/h13c.low.part1106, entries 143805906944 .. 143935930367, chunks 34286 .. 34316
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1106 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1106" 390070272 12582912

end CS31aData.N13
