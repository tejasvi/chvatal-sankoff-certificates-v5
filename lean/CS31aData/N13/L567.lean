import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 567 = cert_data/n13/h13c.low.part0567, entries 73723281408 .. 73853304831, chunks 17577 .. 17607
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l567 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0567" 390070272 12582912

end CS31aData.N13
