import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 86 = cert_data/n13/h13c.low.part0086, entries 11182014464 .. 11312037887, chunks 2666 .. 2696
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l86 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0086" 390070272 12582912

end CS31aData.N13
