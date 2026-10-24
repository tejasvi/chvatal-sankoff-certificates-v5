import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 203 = cert_data/n13/h13c.low.part0203, entries 26394755072 .. 26524778495, chunks 6293 .. 6323
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l203 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0203" 390070272 12582912

end CS31aData.N13
