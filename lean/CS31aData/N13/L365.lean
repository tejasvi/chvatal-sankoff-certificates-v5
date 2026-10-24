import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 365 = cert_data/n13/h13c.low.part0365, entries 47458549760 .. 47588573183, chunks 11315 .. 11345
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l365 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0365" 390070272 12582912

end CS31aData.N13
