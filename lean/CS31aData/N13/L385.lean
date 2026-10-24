import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 385 = cert_data/n13/h13c.low.part0385, entries 50059018240 .. 50189041663, chunks 11935 .. 11965
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l385 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0385" 390070272 12582912

end CS31aData.N13
