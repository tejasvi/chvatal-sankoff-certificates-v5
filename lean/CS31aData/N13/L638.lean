import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 638 = cert_data/n13/h13c.low.part0638, entries 82954944512 .. 83084967935, chunks 19778 .. 19808
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l638 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0638" 390070272 12582912

end CS31aData.N13
