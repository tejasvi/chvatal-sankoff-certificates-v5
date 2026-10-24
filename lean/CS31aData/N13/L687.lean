import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 687 = cert_data/n13/h13c.low.part0687, entries 89326092288 .. 89456115711, chunks 21297 .. 21327
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l687 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0687" 390070272 12582912

end CS31aData.N13
