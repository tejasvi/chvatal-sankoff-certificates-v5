import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 929 = cert_data/n13/h13c.low.part0929, entries 120791760896 .. 120921784319, chunks 28799 .. 28829
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l929 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0929" 390070272 12582912

end CS31aData.N13
