import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 33 = cert_data/n13/h13c.low.part0033, entries 4290772992 .. 4420796415, chunks 1023 .. 1053
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l33 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0033" 390070272 12582912

end CS31aData.N13
