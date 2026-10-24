import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 925 = cert_data/n13/h13c.low.part0925, entries 120271667200 .. 120401690623, chunks 28675 .. 28705
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l925 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0925" 390070272 12582912

end CS31aData.N13
