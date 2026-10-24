import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 280 = cert_data/n13/h13c.low.part0280, entries 36406558720 .. 36536582143, chunks 8680 .. 8710
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l280 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0280" 390070272 12582912

end CS31aData.N13
