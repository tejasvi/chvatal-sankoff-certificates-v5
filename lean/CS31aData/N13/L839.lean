import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 839 = cert_data/n13/h13c.low.part0839, entries 109089652736 .. 109219676159, chunks 26009 .. 26039
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l839 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0839" 390070272 12582912

end CS31aData.N13
