import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 213 = cert_data/n13/h13c.low.part0213, entries 27694989312 .. 27825012735, chunks 6603 .. 6633
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l213 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0213" 390070272 12582912

end CS31aData.N13
