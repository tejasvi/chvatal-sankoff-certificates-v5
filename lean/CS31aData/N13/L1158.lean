import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1158 = cert_data/n13/h13c.low.part1158, entries 150567124992 .. 150697148415, chunks 35898 .. 35928
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1158 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1158" 390070272 12582912

end CS31aData.N13
