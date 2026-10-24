import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1135 = cert_data/n13/h13c.low.part1135, entries 147576586240 .. 147706609663, chunks 35185 .. 35215
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1135 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1135" 390070272 12582912

end CS31aData.N13
