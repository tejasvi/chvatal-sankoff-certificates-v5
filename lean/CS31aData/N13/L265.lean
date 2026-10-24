import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 265 = cert_data/n13/h13c.low.part0265, entries 34456207360 .. 34586230783, chunks 8215 .. 8245
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l265 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0265" 390070272 12582912

end CS31aData.N13
