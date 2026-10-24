import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 30 = cert_data/n13/h13c.low.part0030, entries 3900702720 .. 4030726143, chunks 930 .. 960
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l30 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0030" 390070272 12582912

end CS31aData.N13
