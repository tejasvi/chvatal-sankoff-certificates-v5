import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 112 = cert_data/n13/h13c.low.part0112, entries 14562623488 .. 14692646911, chunks 3472 .. 3502
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l112 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0112" 390070272 12582912

end CS31aData.N13
