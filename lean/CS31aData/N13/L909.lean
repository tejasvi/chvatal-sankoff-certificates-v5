import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 909 = cert_data/n13/h13c.low.part0909, entries 118191292416 .. 118321315839, chunks 28179 .. 28209
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l909 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0909" 390070272 12582912

end CS31aData.N13
