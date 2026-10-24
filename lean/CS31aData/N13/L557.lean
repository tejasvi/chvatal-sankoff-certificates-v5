import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 557 = cert_data/n13/h13c.low.part0557, entries 72423047168 .. 72553070591, chunks 17267 .. 17297
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l557 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0557" 390070272 12582912

end CS31aData.N13
