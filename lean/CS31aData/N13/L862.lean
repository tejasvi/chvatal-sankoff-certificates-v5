import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 862 = cert_data/n13/h13c.low.part0862, entries 112080191488 .. 112210214911, chunks 26722 .. 26752
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l862 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0862" 390070272 12582912

end CS31aData.N13
