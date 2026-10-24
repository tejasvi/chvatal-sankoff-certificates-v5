import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 194 = cert_data/n13/h13c.low.part0194, entries 25224544256 .. 25354567679, chunks 6014 .. 6044
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l194 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0194" 390070272 12582912

end CS31aData.N13
