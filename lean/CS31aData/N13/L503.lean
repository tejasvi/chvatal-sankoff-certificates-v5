import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 503 = cert_data/n13/h13c.low.part0503, entries 65401782272 .. 65531805695, chunks 15593 .. 15623
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l503 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0503" 390070272 12582912

end CS31aData.N13
