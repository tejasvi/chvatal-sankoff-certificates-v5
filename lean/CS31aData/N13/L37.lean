import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 37 = cert_data/n13/h13c.low.part0037, entries 4810866688 .. 4940890111, chunks 1147 .. 1177
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l37 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0037" 390070272 12582912

end CS31aData.N13
