import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 82 = cert_data/n13/h13c.low.part0082, entries 10661920768 .. 10791944191, chunks 2542 .. 2572
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l82 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0082" 390070272 12582912

end CS31aData.N13
