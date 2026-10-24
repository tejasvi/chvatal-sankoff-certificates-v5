import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 531 = cert_data/n13/h13c.low.part0531, entries 69042438144 .. 69172461567, chunks 16461 .. 16491
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l531 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0531" 390070272 12582912

end CS31aData.N13
