import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 262 = cert_data/n13/h13c.low.part0262, entries 34066137088 .. 34196160511, chunks 8122 .. 8152
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l262 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0262" 390070272 12582912

end CS31aData.N13
