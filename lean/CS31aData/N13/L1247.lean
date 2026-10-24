import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1247 = cert_data/n13/h13c.low.part1247, entries 162139209728 .. 162269233151, chunks 38657 .. 38687
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1247 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1247" 390070272 12582912

end CS31aData.N13
