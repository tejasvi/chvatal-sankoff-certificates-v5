import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 908 = cert_data/n13/h13c.low.part0908, entries 118061268992 .. 118191292415, chunks 28148 .. 28178
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l908 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0908" 390070272 12582912

end CS31aData.N13
