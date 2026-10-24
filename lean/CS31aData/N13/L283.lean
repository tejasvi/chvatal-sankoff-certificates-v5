import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 283 = cert_data/n13/h13c.low.part0283, entries 36796628992 .. 36926652415, chunks 8773 .. 8803
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l283 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0283" 390070272 12582912

end CS31aData.N13
