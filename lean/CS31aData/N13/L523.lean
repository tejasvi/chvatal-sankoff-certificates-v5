import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 523 = cert_data/n13/h13c.low.part0523, entries 68002250752 .. 68132274175, chunks 16213 .. 16243
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l523 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0523" 390070272 12582912

end CS31aData.N13
