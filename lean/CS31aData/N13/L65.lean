import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 65 = cert_data/n13/h13c.low.part0065, entries 8451522560 .. 8581545983, chunks 2015 .. 2045
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l65 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0065" 390070272 12582912

end CS31aData.N13
