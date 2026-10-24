import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 297 = cert_data/n13/h13c.low.part0297, entries 38616956928 .. 38746980351, chunks 9207 .. 9237
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l297 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0297" 390070272 12582912

end CS31aData.N13
