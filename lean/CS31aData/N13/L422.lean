import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 422 = cert_data/n13/h13c.low.part0422, entries 54869884928 .. 54999908351, chunks 13082 .. 13112
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l422 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0422" 390070272 12582912

end CS31aData.N13
