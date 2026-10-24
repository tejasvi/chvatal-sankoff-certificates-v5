import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1234 = cert_data/n13/h13c.low.part1234, entries 160448905216 .. 160578928639, chunks 38254 .. 38284
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1234 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1234" 390070272 12582912

end CS31aData.N13
