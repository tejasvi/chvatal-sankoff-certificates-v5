import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1266 = cert_data/n13/h13c.low.part1266, entries 164609654784 .. 164739678207, chunks 39246 .. 39276
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1266 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1266" 390070272 12582912

end CS31aData.N13
