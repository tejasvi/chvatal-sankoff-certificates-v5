import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 281 = cert_data/n13/h13c.low.part0281, entries 36536582144 .. 36666605567, chunks 8711 .. 8741
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l281 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0281" 390070272 12582912

end CS31aData.N13
