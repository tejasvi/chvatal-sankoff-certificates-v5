import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 581 = cert_data/n13/h13c.low.part0581, entries 75543609344 .. 75673632767, chunks 18011 .. 18041
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l581 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0581" 390070272 12582912

end CS31aData.N13
