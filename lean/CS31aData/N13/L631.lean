import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 631 = cert_data/n13/h13c.low.part0631, entries 82044780544 .. 82174803967, chunks 19561 .. 19591
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l631 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0631" 390070272 12582912

end CS31aData.N13
