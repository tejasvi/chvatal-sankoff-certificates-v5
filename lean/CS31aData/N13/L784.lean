import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 784 = cert_data/n13/h13c.low.part0784, entries 101938364416 .. 102068387839, chunks 24304 .. 24334
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l784 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0784" 390070272 12582912

end CS31aData.N13
