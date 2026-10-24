import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 153 = cert_data/n13/h13c.low.part0153, entries 19893583872 .. 20023607295, chunks 4743 .. 4773
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l153 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0153" 390070272 12582912

end CS31aData.N13
