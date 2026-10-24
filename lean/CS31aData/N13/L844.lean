import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 844 = cert_data/n13/h13c.low.part0844, entries 109739769856 .. 109869793279, chunks 26164 .. 26194
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l844 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0844" 390070272 12582912

end CS31aData.N13
