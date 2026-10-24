import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 461 = cert_data/n13/h13c.low.part0461, entries 59940798464 .. 60070821887, chunks 14291 .. 14321
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l461 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0461" 390070272 12582912

end CS31aData.N13
