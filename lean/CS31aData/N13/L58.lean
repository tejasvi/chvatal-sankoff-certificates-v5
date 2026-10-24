import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 58 = cert_data/n13/h13c.low.part0058, entries 7541358592 .. 7671382015, chunks 1798 .. 1828
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l58 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0058" 390070272 12582912

end CS31aData.N13
