import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 186 = cert_data/n13/h13c.low.part0186, entries 24184356864 .. 24314380287, chunks 5766 .. 5796
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l186 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0186" 390070272 12582912

end CS31aData.N13
