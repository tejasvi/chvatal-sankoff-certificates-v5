import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 170 = cert_data/n13/h13c.low.part0170, entries 22103982080 .. 22234005503, chunks 5270 .. 5300
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l170 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0170" 390070272 12582912

end CS31aData.N13
