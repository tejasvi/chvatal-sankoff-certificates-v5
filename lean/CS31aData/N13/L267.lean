import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 267 = cert_data/n13/h13c.low.part0267, entries 34716254208 .. 34846277631, chunks 8277 .. 8307
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l267 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0267" 390070272 12582912

end CS31aData.N13
