import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 296 = cert_data/n13/h13c.low.part0296, entries 38486933504 .. 38616956927, chunks 9176 .. 9206
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l296 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0296" 390070272 12582912

end CS31aData.N13
