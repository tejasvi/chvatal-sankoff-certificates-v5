import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 771 = cert_data/n13/h13c.low.part0771, entries 100248059904 .. 100378083327, chunks 23901 .. 23931
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l771 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0771" 390070272 12582912

end CS31aData.N13
