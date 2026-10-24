import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 286 = cert_data/n13/h13c.low.part0286, entries 37186699264 .. 37316722687, chunks 8866 .. 8896
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l286 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0286" 390070272 12582912

end CS31aData.N13
