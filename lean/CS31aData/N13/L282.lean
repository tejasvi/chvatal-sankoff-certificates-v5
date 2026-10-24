import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 282 = cert_data/n13/h13c.low.part0282, entries 36666605568 .. 36796628991, chunks 8742 .. 8772
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l282 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0282" 390070272 12582912

end CS31aData.N13
