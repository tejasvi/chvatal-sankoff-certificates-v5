import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 613 = cert_data/n13/h13c.low.part0613, entries 79704358912 .. 79834382335, chunks 19003 .. 19033
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l613 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0613" 390070272 12582912

end CS31aData.N13
