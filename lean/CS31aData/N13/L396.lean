import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 396 = cert_data/n13/h13c.low.part0396, entries 51489275904 .. 51619299327, chunks 12276 .. 12306
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l396 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0396" 390070272 12582912

end CS31aData.N13
