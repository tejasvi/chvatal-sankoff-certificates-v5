import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1097 = cert_data/n13/h13c.low.part1097, entries 142635696128 .. 142765719551, chunks 34007 .. 34037
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1097 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1097" 390070272 12582912

end CS31aData.N13
