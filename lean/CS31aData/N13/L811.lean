import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 811 = cert_data/n13/h13c.low.part0811, entries 105448996864 .. 105579020287, chunks 25141 .. 25171
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l811 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0811" 390070272 12582912

end CS31aData.N13
