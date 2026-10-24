import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 496 = cert_data/n13/h13c.low.part0496, entries 64491618304 .. 64621641727, chunks 15376 .. 15406
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l496 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0496" 390070272 12582912

end CS31aData.N13
