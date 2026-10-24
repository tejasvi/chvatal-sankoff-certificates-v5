import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 605 = cert_data/n13/h13c.low.part0605, entries 78664171520 .. 78794194943, chunks 18755 .. 18785
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l605 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0605" 390070272 12582912

end CS31aData.N13
