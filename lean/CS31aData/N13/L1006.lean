import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1006 = cert_data/n13/h13c.low.part1006, entries 130803564544 .. 130933587967, chunks 31186 .. 31216
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1006 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1006" 390070272 12582912

end CS31aData.N13
