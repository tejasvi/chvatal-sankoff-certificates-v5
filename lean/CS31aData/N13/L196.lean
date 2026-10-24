import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 196 = cert_data/n13/h13c.low.part0196, entries 25484591104 .. 25614614527, chunks 6076 .. 6106
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l196 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0196" 390070272 12582912

end CS31aData.N13
