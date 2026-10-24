import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 907 = cert_data/n13/h13c.low.part0907, entries 117931245568 .. 118061268991, chunks 28117 .. 28147
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l907 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0907" 390070272 12582912

end CS31aData.N13
