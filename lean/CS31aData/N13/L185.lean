import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 185 = cert_data/n13/h13c.low.part0185, entries 24054333440 .. 24184356863, chunks 5735 .. 5765
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l185 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0185" 390070272 12582912

end CS31aData.N13
