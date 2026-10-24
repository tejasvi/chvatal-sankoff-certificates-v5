import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 484 = cert_data/n13/h13c.low.part0484, entries 62931337216 .. 63061360639, chunks 15004 .. 15034
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l484 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0484" 390070272 12582912

end CS31aData.N13
