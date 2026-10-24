import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 804 = cert_data/n13/h13c.low.part0804, entries 104538832896 .. 104668856319, chunks 24924 .. 24954
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l804 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0804" 390070272 12582912

end CS31aData.N13
