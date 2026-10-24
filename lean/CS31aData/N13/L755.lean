import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 755 = cert_data/n13/h13c.low.part0755, entries 98167685120 .. 98297708543, chunks 23405 .. 23435
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l755 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0755" 390070272 12582912

end CS31aData.N13
