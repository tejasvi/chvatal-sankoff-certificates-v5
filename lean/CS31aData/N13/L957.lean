import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 957 = cert_data/n13/h13c.low.part0957, entries 124432416768 .. 124562440191, chunks 29667 .. 29697
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l957 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0957" 390070272 12582912

end CS31aData.N13
