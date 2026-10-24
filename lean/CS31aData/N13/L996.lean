import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 996 = cert_data/n13/h13c.low.part0996, entries 129503330304 .. 129633353727, chunks 30876 .. 30906
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l996 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0996" 390070272 12582912

end CS31aData.N13
