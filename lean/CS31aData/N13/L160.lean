import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 160 = cert_data/n13/h13c.low.part0160, entries 20803747840 .. 20933771263, chunks 4960 .. 4990
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l160 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0160" 390070272 12582912

end CS31aData.N13
