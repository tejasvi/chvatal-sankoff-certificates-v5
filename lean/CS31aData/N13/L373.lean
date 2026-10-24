import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 373 = cert_data/n13/h13c.low.part0373, entries 48498737152 .. 48628760575, chunks 11563 .. 11593
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l373 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0373" 390070272 12582912

end CS31aData.N13
