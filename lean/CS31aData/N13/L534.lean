import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 534 = cert_data/n13/h13c.low.part0534, entries 69432508416 .. 69562531839, chunks 16554 .. 16584
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l534 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0534" 390070272 12582912

end CS31aData.N13
