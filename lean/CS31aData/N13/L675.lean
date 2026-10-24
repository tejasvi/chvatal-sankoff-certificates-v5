import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 675 = cert_data/n13/h13c.low.part0675, entries 87765811200 .. 87895834623, chunks 20925 .. 20955
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l675 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0675" 390070272 12582912

end CS31aData.N13
