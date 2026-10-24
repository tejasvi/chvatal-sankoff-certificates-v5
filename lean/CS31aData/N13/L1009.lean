import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1009 = cert_data/n13/h13c.low.part1009, entries 131193634816 .. 131323658239, chunks 31279 .. 31309
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1009 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1009" 390070272 12582912

end CS31aData.N13
