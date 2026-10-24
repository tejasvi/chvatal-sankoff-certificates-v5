import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 68 = cert_data/n13/h13c.low.part0068, entries 8841592832 .. 8971616255, chunks 2108 .. 2138
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l68 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0068" 390070272 12582912

end CS31aData.N13
