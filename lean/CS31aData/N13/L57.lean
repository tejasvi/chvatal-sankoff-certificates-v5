import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 57 = cert_data/n13/h13c.low.part0057, entries 7411335168 .. 7541358591, chunks 1767 .. 1797
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l57 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0057" 390070272 12582912

end CS31aData.N13
