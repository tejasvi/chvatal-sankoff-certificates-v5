import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 320 = cert_data/n13/h13c.low.part0320, entries 41607495680 .. 41737519103, chunks 9920 .. 9950
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l320 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0320" 390070272 12582912

end CS31aData.N13
