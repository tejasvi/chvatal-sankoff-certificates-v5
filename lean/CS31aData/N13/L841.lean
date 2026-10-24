import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 841 = cert_data/n13/h13c.low.part0841, entries 109349699584 .. 109479723007, chunks 26071 .. 26101
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l841 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0841" 390070272 12582912

end CS31aData.N13
