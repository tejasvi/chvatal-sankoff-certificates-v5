import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 55 = cert_data/n13/h13c.low.part0055, entries 7151288320 .. 7281311743, chunks 1705 .. 1735
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l55 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0055" 390070272 12582912

end CS31aData.N13
