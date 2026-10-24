import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1148 = cert_data/n13/h13c.low.part1148, entries 149266890752 .. 149396914175, chunks 35588 .. 35618
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1148 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1148" 390070272 12582912

end CS31aData.N13
