import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 715 = cert_data/n13/h13c.low.part0715, entries 92966748160 .. 93096771583, chunks 22165 .. 22195
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l715 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0715" 390070272 12582912

end CS31aData.N13
