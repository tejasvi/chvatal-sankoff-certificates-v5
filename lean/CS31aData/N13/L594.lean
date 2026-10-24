import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 594 = cert_data/n13/h13c.low.part0594, entries 77233913856 .. 77363937279, chunks 18414 .. 18444
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l594 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0594" 390070272 12582912

end CS31aData.N13
