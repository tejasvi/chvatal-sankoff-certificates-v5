import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1076 = cert_data/n13/h13c.low.part1076, entries 139905204224 .. 140035227647, chunks 33356 .. 33386
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1076 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1076" 390070272 12582912

end CS31aData.N13
