import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 488 = cert_data/n13/h13c.low.part0488, entries 63451430912 .. 63581454335, chunks 15128 .. 15158
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l488 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0488" 390070272 12582912

end CS31aData.N13
