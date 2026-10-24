import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 658 = cert_data/n13/h13c.low.part0658, entries 85555412992 .. 85685436415, chunks 20398 .. 20428
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l658 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0658" 390070272 12582912

end CS31aData.N13
