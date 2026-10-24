import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 238 = cert_data/n13/h13c.low.part0238, entries 30945574912 .. 31075598335, chunks 7378 .. 7408
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l238 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0238" 390070272 12582912

end CS31aData.N13
