import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 903 = cert_data/n13/h13c.low.part0903, entries 117411151872 .. 117541175295, chunks 27993 .. 28023
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l903 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0903" 390070272 12582912

end CS31aData.N13
