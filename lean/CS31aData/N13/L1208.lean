import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1208 = cert_data/n13/h13c.low.part1208, entries 157068296192 .. 157198319615, chunks 37448 .. 37478
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1208 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1208" 390070272 12582912

end CS31aData.N13
