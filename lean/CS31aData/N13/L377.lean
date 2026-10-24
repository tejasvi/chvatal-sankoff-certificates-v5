import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 377 = cert_data/n13/h13c.low.part0377, entries 49018830848 .. 49148854271, chunks 11687 .. 11717
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l377 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0377" 390070272 12582912

end CS31aData.N13
