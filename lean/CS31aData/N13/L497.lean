import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 497 = cert_data/n13/h13c.low.part0497, entries 64621641728 .. 64751665151, chunks 15407 .. 15437
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l497 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0497" 390070272 12582912

end CS31aData.N13
