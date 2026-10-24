import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1195 = cert_data/n13/h13c.low.part1195, entries 155377991680 .. 155508015103, chunks 37045 .. 37075
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1195 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1195" 390070272 12582912

end CS31aData.N13
