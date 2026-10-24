import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 880 = cert_data/n13/h13c.low.part0880, entries 114420613120 .. 114550636543, chunks 27280 .. 27310
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l880 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0880" 390070272 12582912

end CS31aData.N13
