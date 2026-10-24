import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 133 = cert_data/n13/h13c.low.part0133, entries 17293115392 .. 17423138815, chunks 4123 .. 4153
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l133 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0133" 390070272 12582912

end CS31aData.N13
