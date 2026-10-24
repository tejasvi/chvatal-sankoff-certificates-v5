import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 98 = cert_data/n13/h13c.low.part0098, entries 12742295552 .. 12872318975, chunks 3038 .. 3068
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l98 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0098" 390070272 12582912

end CS31aData.N13
