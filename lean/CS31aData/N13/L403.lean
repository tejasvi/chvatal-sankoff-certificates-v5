import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 403 = cert_data/n13/h13c.low.part0403, entries 52399439872 .. 52529463295, chunks 12493 .. 12523
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l403 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0403" 390070272 12582912

end CS31aData.N13
