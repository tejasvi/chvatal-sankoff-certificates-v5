import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 608 = cert_data/n13/h13c.low.part0608, entries 79054241792 .. 79184265215, chunks 18848 .. 18878
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l608 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0608" 390070272 12582912

end CS31aData.N13
