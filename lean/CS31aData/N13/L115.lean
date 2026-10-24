import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 115 = cert_data/n13/h13c.low.part0115, entries 14952693760 .. 15082717183, chunks 3565 .. 3595
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l115 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0115" 390070272 12582912

end CS31aData.N13
