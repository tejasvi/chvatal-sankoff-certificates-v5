import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 736 = cert_data/n13/h13c.low.part0736, entries 95697240064 .. 95827263487, chunks 22816 .. 22846
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l736 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0736" 390070272 12582912

end CS31aData.N13
