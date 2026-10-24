import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 591 = cert_data/n13/h13c.low.part0591, entries 76843843584 .. 76973867007, chunks 18321 .. 18351
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l591 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0591" 390070272 12582912

end CS31aData.N13
