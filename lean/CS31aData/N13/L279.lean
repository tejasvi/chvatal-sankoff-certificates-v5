import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 279 = cert_data/n13/h13c.low.part0279, entries 36276535296 .. 36406558719, chunks 8649 .. 8679
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l279 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0279" 390070272 12582912

end CS31aData.N13
