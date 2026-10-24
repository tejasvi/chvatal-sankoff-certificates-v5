import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 668 = cert_data/n13/h13c.low.part0668, entries 86855647232 .. 86985670655, chunks 20708 .. 20738
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l668 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0668" 390070272 12582912

end CS31aData.N13
