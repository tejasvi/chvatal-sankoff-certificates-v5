import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 653 = cert_data/n13/h13c.low.part0653, entries 84905295872 .. 85035319295, chunks 20243 .. 20273
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l653 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0653" 390070272 12582912

end CS31aData.N13
