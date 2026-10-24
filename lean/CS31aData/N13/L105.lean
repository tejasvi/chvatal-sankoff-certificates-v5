import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 105 = cert_data/n13/h13c.low.part0105, entries 13652459520 .. 13782482943, chunks 3255 .. 3285
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l105 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0105" 390070272 12582912

end CS31aData.N13
