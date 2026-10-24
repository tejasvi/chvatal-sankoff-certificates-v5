import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 435 = cert_data/n13/h13c.low.part0435, entries 56560189440 .. 56690212863, chunks 13485 .. 13515
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l435 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0435" 390070272 12582912

end CS31aData.N13
