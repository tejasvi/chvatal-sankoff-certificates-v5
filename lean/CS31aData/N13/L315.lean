import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 315 = cert_data/n13/h13c.low.part0315, entries 40957378560 .. 41087401983, chunks 9765 .. 9795
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l315 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0315" 390070272 12582912

end CS31aData.N13
