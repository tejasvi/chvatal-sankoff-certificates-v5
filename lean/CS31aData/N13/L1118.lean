import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1118 = cert_data/n13/h13c.low.part1118, entries 145366188032 .. 145496211455, chunks 34658 .. 34688
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1118 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1118" 390070272 12582912

end CS31aData.N13
