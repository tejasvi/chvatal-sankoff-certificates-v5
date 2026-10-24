import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 539 = cert_data/n13/h13c.low.part0539, entries 70082625536 .. 70212648959, chunks 16709 .. 16739
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l539 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0539" 390070272 12582912

end CS31aData.N13
