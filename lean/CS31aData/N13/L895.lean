import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 895 = cert_data/n13/h13c.low.part0895, entries 116370964480 .. 116500987903, chunks 27745 .. 27775
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l895 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0895" 390070272 12582912

end CS31aData.N13
