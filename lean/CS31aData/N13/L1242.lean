import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1242 = cert_data/n13/h13c.low.part1242, entries 161489092608 .. 161619116031, chunks 38502 .. 38532
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1242 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1242" 390070272 12582912

end CS31aData.N13
