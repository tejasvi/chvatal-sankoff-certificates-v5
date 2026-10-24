import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1098 = cert_data/n13/h13c.low.part1098, entries 142765719552 .. 142895742975, chunks 34038 .. 34068
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1098 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1098" 390070272 12582912

end CS31aData.N13
