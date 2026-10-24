import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 111 = cert_data/n13/h13c.low.part0111, entries 14432600064 .. 14562623487, chunks 3441 .. 3471
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l111 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0111" 390070272 12582912

end CS31aData.N13
