import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 40 = cert_data/n13/h13c.low.part0040, entries 5200936960 .. 5330960383, chunks 1240 .. 1270
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l40 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0040" 390070272 12582912

end CS31aData.N13
