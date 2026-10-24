import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 630 = cert_data/n13/h13c.low.part0630, entries 81914757120 .. 82044780543, chunks 19530 .. 19560
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l630 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0630" 390070272 12582912

end CS31aData.N13
