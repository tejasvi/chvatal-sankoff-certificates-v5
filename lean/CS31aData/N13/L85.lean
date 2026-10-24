import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 85 = cert_data/n13/h13c.low.part0085, entries 11051991040 .. 11182014463, chunks 2635 .. 2665
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l85 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0085" 390070272 12582912

end CS31aData.N13
