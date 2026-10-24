import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 109 = cert_data/n13/h13c.low.part0109, entries 14172553216 .. 14302576639, chunks 3379 .. 3409
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l109 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0109" 390070272 12582912

end CS31aData.N13
