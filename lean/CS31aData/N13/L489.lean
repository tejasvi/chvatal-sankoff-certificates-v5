import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 489 = cert_data/n13/h13c.low.part0489, entries 63581454336 .. 63711477759, chunks 15159 .. 15189
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l489 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0489" 390070272 12582912

end CS31aData.N13
