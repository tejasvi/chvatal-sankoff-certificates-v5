import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 172 = cert_data/n13/h13c.low.part0172, entries 22364028928 .. 22494052351, chunks 5332 .. 5362
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l172 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0172" 390070272 12582912

end CS31aData.N13
