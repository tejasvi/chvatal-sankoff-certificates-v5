import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 812 = cert_data/n13/h13c.low.part0812, entries 105579020288 .. 105709043711, chunks 25172 .. 25202
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l812 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0812" 390070272 12582912

end CS31aData.N13
