import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 421 = cert_data/n13/h13c.low.part0421, entries 54739861504 .. 54869884927, chunks 13051 .. 13081
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l421 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0421" 390070272 12582912

end CS31aData.N13
