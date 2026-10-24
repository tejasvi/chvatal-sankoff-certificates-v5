import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 319 = cert_data/n13/h13c.low.part0319, entries 41477472256 .. 41607495679, chunks 9889 .. 9919
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l319 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0319" 390070272 12582912

end CS31aData.N13
