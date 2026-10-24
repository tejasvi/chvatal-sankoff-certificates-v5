import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 150 = cert_data/n13/h13c.low.part0150, entries 19503513600 .. 19633537023, chunks 4650 .. 4680
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l150 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0150" 390070272 12582912

end CS31aData.N13
