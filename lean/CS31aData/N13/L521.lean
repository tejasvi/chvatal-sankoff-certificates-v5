import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 521 = cert_data/n13/h13c.low.part0521, entries 67742203904 .. 67872227327, chunks 16151 .. 16181
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l521 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0521" 390070272 12582912

end CS31aData.N13
