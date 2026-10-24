import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1100 = cert_data/n13/h13c.low.part1100, entries 143025766400 .. 143155789823, chunks 34100 .. 34130
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1100 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1100" 390070272 12582912

end CS31aData.N13
