import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 706 = cert_data/n13/h13c.low.part0706, entries 91796537344 .. 91926560767, chunks 21886 .. 21916
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l706 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0706" 390070272 12582912

end CS31aData.N13
