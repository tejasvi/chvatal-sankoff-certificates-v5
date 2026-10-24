import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 817 = cert_data/n13/h13c.low.part0817, entries 106229137408 .. 106359160831, chunks 25327 .. 25357
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l817 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0817" 390070272 12582912

end CS31aData.N13
