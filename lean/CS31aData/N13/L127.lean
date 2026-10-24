import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 127 = cert_data/n13/h13c.low.part0127, entries 16512974848 .. 16642998271, chunks 3937 .. 3967
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l127 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0127" 390070272 12582912

end CS31aData.N13
