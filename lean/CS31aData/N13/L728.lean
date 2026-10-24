import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 728 = cert_data/n13/h13c.low.part0728, entries 94657052672 .. 94787076095, chunks 22568 .. 22598
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l728 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0728" 390070272 12582912

end CS31aData.N13
