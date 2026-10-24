import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 827 = cert_data/n13/h13c.low.part0827, entries 107529371648 .. 107659395071, chunks 25637 .. 25667
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l827 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0827" 390070272 12582912

end CS31aData.N13
