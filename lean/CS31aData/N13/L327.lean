import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 327 = cert_data/n13/h13c.low.part0327, entries 42517659648 .. 42647683071, chunks 10137 .. 10167
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l327 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0327" 390070272 12582912

end CS31aData.N13
