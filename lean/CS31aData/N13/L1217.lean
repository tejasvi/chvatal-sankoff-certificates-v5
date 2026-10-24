import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1217 = cert_data/n13/h13c.low.part1217, entries 158238507008 .. 158368530431, chunks 37727 .. 37757
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1217 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1217" 390070272 12582912

end CS31aData.N13
