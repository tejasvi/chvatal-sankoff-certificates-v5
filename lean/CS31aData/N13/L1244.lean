import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1244 = cert_data/n13/h13c.low.part1244, entries 161749139456 .. 161879162879, chunks 38564 .. 38594
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1244 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1244" 390070272 12582912

end CS31aData.N13
