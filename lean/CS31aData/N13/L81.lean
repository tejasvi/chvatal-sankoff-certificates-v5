import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 81 = cert_data/n13/h13c.low.part0081, entries 10531897344 .. 10661920767, chunks 2511 .. 2541
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l81 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0081" 390070272 12582912

end CS31aData.N13
