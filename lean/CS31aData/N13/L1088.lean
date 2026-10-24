import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1088 = cert_data/n13/h13c.low.part1088, entries 141465485312 .. 141595508735, chunks 33728 .. 33758
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1088 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1088" 390070272 12582912

end CS31aData.N13
