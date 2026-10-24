import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 470 = cert_data/n13/h13c.low.part0470, entries 61111009280 .. 61241032703, chunks 14570 .. 14600
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l470 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0470" 390070272 12582912

end CS31aData.N13
