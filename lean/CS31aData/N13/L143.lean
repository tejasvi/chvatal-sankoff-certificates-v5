import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 143 = cert_data/n13/h13c.low.part0143, entries 18593349632 .. 18723373055, chunks 4433 .. 4463
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l143 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0143" 390070272 12582912

end CS31aData.N13
