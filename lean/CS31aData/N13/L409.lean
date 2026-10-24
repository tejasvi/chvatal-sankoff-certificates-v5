import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 409 = cert_data/n13/h13c.low.part0409, entries 53179580416 .. 53309603839, chunks 12679 .. 12709
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l409 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0409" 390070272 12582912

end CS31aData.N13
