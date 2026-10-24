import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 179 = cert_data/n13/h13c.low.part0179, entries 23274192896 .. 23404216319, chunks 5549 .. 5579
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l179 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0179" 390070272 12582912

end CS31aData.N13
