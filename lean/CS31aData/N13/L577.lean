import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 577 = cert_data/n13/h13c.low.part0577, entries 75023515648 .. 75153539071, chunks 17887 .. 17917
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l577 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0577" 390070272 12582912

end CS31aData.N13
