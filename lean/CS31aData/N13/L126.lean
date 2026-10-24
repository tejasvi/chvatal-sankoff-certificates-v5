import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 126 = cert_data/n13/h13c.low.part0126, entries 16382951424 .. 16512974847, chunks 3906 .. 3936
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l126 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0126" 390070272 12582912

end CS31aData.N13
