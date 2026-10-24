import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 42 = cert_data/n13/h13c.low.part0042, entries 5460983808 .. 5591007231, chunks 1302 .. 1332
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l42 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0042" 390070272 12582912

end CS31aData.N13
