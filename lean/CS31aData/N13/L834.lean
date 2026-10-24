import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 834 = cert_data/n13/h13c.low.part0834, entries 108439535616 .. 108569559039, chunks 25854 .. 25884
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l834 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0834" 390070272 12582912

end CS31aData.N13
