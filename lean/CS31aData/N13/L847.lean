import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 847 = cert_data/n13/h13c.low.part0847, entries 110129840128 .. 110259863551, chunks 26257 .. 26287
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l847 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0847" 390070272 12582912

end CS31aData.N13
