import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 285 = cert_data/n13/h13c.low.part0285, entries 37056675840 .. 37186699263, chunks 8835 .. 8865
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l285 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0285" 390070272 12582912

end CS31aData.N13
