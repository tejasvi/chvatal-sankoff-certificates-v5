import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1092 = cert_data/n13/h13c.low.part1092, entries 141985579008 .. 142115602431, chunks 33852 .. 33882
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1092 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1092" 390070272 12582912

end CS31aData.N13
