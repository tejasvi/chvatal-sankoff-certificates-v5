import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 149 = cert_data/n13/h13c.low.part0149, entries 19373490176 .. 19503513599, chunks 4619 .. 4649
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l149 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0149" 390070272 12582912

end CS31aData.N13
