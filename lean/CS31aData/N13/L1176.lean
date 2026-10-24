import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1176 = cert_data/n13/h13c.low.part1176, entries 152907546624 .. 153037570047, chunks 36456 .. 36486
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1176 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1176" 390070272 12582912

end CS31aData.N13
