import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 73 = cert_data/n13/h13c.low.part0073, entries 9491709952 .. 9621733375, chunks 2263 .. 2293
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l73 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0073" 390070272 12582912

end CS31aData.N13
