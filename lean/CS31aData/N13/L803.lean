import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 803 = cert_data/n13/h13c.low.part0803, entries 104408809472 .. 104538832895, chunks 24893 .. 24923
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l803 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0803" 390070272 12582912

end CS31aData.N13
