import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 614 = cert_data/n13/h13c.low.part0614, entries 79834382336 .. 79964405759, chunks 19034 .. 19064
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l614 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0614" 390070272 12582912

end CS31aData.N13
