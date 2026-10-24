import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 787 = cert_data/n13/h13c.low.part0787, entries 102328434688 .. 102458458111, chunks 24397 .. 24427
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l787 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0787" 390070272 12582912

end CS31aData.N13
