import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 963 = cert_data/n13/h13c.low.part0963, entries 125212557312 .. 125342580735, chunks 29853 .. 29883
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l963 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0963" 390070272 12582912

end CS31aData.N13
