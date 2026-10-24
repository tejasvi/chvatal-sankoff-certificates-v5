import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 576 = cert_data/n13/h13c.low.part0576, entries 74893492224 .. 75023515647, chunks 17856 .. 17886
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l576 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0576" 390070272 12582912

end CS31aData.N13
