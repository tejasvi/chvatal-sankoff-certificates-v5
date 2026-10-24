import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 717 = cert_data/n13/h13c.low.part0717, entries 93226795008 .. 93356818431, chunks 22227 .. 22257
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l717 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0717" 390070272 12582912

end CS31aData.N13
