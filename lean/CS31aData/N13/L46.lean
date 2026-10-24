import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 46 = cert_data/n13/h13c.low.part0046, entries 5981077504 .. 6111100927, chunks 1426 .. 1456
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l46 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0046" 390070272 12582912

end CS31aData.N13
