import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 381 = cert_data/n13/h13c.low.part0381, entries 49538924544 .. 49668947967, chunks 11811 .. 11841
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l381 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0381" 390070272 12582912

end CS31aData.N13
