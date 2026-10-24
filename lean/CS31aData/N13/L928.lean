import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 928 = cert_data/n13/h13c.low.part0928, entries 120661737472 .. 120791760895, chunks 28768 .. 28798
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l928 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0928" 390070272 12582912

end CS31aData.N13
