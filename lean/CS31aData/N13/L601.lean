import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 601 = cert_data/n13/h13c.low.part0601, entries 78144077824 .. 78274101247, chunks 18631 .. 18661
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l601 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0601" 390070272 12582912

end CS31aData.N13
