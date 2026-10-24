import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1194 = cert_data/n13/h13c.low.part1194, entries 155247968256 .. 155377991679, chunks 37014 .. 37044
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1194 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1194" 390070272 12582912

end CS31aData.N13
