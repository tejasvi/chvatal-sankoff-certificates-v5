import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1116 = cert_data/n13/h13c.low.part1116, entries 145106141184 .. 145236164607, chunks 34596 .. 34626
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1116 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1116" 390070272 12582912

end CS31aData.N13
