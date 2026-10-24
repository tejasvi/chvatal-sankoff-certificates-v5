import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 94 = cert_data/n13/h13c.low.part0094, entries 12222201856 .. 12352225279, chunks 2914 .. 2944
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l94 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0094" 390070272 12582912

end CS31aData.N13
