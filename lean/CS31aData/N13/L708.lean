import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 708 = cert_data/n13/h13c.low.part0708, entries 92056584192 .. 92186607615, chunks 21948 .. 21978
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l708 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0708" 390070272 12582912

end CS31aData.N13
