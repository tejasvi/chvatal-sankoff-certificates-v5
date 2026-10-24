import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 763 = cert_data/n13/h13c.low.part0763, entries 99207872512 .. 99337895935, chunks 23653 .. 23683
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l763 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0763" 390070272 12582912

end CS31aData.N13
