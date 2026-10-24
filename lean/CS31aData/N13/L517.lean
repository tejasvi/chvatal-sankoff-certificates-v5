import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 517 = cert_data/n13/h13c.low.part0517, entries 67222110208 .. 67352133631, chunks 16027 .. 16057
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l517 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0517" 390070272 12582912

end CS31aData.N13
