import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 994 = cert_data/n13/h13c.low.part0994, entries 129243283456 .. 129373306879, chunks 30814 .. 30844
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l994 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0994" 390070272 12582912

end CS31aData.N13
