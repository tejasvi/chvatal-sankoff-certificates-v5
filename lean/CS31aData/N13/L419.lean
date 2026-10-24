import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 419 = cert_data/n13/h13c.low.part0419, entries 54479814656 .. 54609838079, chunks 12989 .. 13019
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l419 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0419" 390070272 12582912

end CS31aData.N13
