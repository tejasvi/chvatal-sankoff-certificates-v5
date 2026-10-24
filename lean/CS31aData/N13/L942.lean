import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 942 = cert_data/n13/h13c.low.part0942, entries 122482065408 .. 122612088831, chunks 29202 .. 29232
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l942 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0942" 390070272 12582912

end CS31aData.N13
