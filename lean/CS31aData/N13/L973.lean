import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 973 = cert_data/n13/h13c.low.part0973, entries 126512791552 .. 126642814975, chunks 30163 .. 30193
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l973 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0973" 390070272 12582912

end CS31aData.N13
