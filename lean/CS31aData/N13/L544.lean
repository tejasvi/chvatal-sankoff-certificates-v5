import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 544 = cert_data/n13/h13c.low.part0544, entries 70732742656 .. 70862766079, chunks 16864 .. 16894
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l544 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0544" 390070272 12582912

end CS31aData.N13
