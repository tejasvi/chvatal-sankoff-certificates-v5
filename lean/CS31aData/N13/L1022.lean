import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1022 = cert_data/n13/h13c.low.part1022, entries 132883939328 .. 133013962751, chunks 31682 .. 31712
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1022 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1022" 390070272 12582912

end CS31aData.N13
