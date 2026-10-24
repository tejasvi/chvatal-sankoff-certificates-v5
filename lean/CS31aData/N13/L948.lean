import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 948 = cert_data/n13/h13c.low.part0948, entries 123262205952 .. 123392229375, chunks 29388 .. 29418
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l948 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0948" 390070272 12582912

end CS31aData.N13
