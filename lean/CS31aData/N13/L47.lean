import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 47 = cert_data/n13/h13c.low.part0047, entries 6111100928 .. 6241124351, chunks 1457 .. 1487
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l47 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0047" 390070272 12582912

end CS31aData.N13
