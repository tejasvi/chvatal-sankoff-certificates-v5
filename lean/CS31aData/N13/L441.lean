import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 441 = cert_data/n13/h13c.low.part0441, entries 57340329984 .. 57470353407, chunks 13671 .. 13701
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l441 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0441" 390070272 12582912

end CS31aData.N13
