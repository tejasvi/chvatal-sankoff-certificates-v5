import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1255 = cert_data/n13/h13c.low.part1255, entries 163179397120 .. 163309420543, chunks 38905 .. 38935
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1255 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1255" 390070272 12582912

end CS31aData.N13
