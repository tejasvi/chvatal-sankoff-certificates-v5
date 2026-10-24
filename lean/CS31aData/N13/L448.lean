import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 448 = cert_data/n13/h13c.low.part0448, entries 58250493952 .. 58380517375, chunks 13888 .. 13918
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l448 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0448" 390070272 12582912

end CS31aData.N13
