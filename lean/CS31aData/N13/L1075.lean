import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1075 = cert_data/n13/h13c.low.part1075, entries 139775180800 .. 139905204223, chunks 33325 .. 33355
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1075 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1075" 390070272 12582912

end CS31aData.N13
