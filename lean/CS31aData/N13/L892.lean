import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 892 = cert_data/n13/h13c.low.part0892, entries 115980894208 .. 116110917631, chunks 27652 .. 27682
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l892 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0892" 390070272 12582912

end CS31aData.N13
