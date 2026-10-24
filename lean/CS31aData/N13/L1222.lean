import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1222 = cert_data/n13/h13c.low.part1222, entries 158888624128 .. 159018647551, chunks 37882 .. 37912
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1222 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1222" 390070272 12582912

end CS31aData.N13
