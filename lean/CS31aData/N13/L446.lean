import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 446 = cert_data/n13/h13c.low.part0446, entries 57990447104 .. 58120470527, chunks 13826 .. 13856
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l446 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0446" 390070272 12582912

end CS31aData.N13
