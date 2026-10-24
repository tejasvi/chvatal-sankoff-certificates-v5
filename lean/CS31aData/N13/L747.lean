import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 747 = cert_data/n13/h13c.low.part0747, entries 97127497728 .. 97257521151, chunks 23157 .. 23187
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l747 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0747" 390070272 12582912

end CS31aData.N13
