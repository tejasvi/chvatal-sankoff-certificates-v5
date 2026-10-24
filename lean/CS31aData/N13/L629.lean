import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 629 = cert_data/n13/h13c.low.part0629, entries 81784733696 .. 81914757119, chunks 19499 .. 19529
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l629 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0629" 390070272 12582912

end CS31aData.N13
