import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 401 = cert_data/n13/h13c.low.part0401, entries 52139393024 .. 52269416447, chunks 12431 .. 12461
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l401 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0401" 390070272 12582912

end CS31aData.N13
