import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 72 = cert_data/n13/h13c.low.part0072, entries 9361686528 .. 9491709951, chunks 2232 .. 2262
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l72 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0072" 390070272 12582912

end CS31aData.N13
