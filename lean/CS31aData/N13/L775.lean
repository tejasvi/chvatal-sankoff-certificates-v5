import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 775 = cert_data/n13/h13c.low.part0775, entries 100768153600 .. 100898177023, chunks 24025 .. 24055
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l775 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0775" 390070272 12582912

end CS31aData.N13
