import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 989 = cert_data/n13/h13c.low.part0989, entries 128593166336 .. 128723189759, chunks 30659 .. 30689
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l989 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0989" 390070272 12582912

end CS31aData.N13
