import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 823 = cert_data/n13/h13c.low.part0823, entries 107009277952 .. 107139301375, chunks 25513 .. 25543
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l823 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0823" 390070272 12582912

end CS31aData.N13
