import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 931 = cert_data/n13/h13c.low.part0931, entries 121051807744 .. 121181831167, chunks 28861 .. 28891
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l931 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0931" 390070272 12582912

end CS31aData.N13
