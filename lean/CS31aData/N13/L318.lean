import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 318 = cert_data/n13/h13c.low.part0318, entries 41347448832 .. 41477472255, chunks 9858 .. 9888
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l318 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0318" 390070272 12582912

end CS31aData.N13
