import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 364 = cert_data/n13/h13c.low.part0364, entries 47328526336 .. 47458549759, chunks 11284 .. 11314
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l364 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0364" 390070272 12582912

end CS31aData.N13
