import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 674 = cert_data/n13/h13c.low.part0674, entries 87635787776 .. 87765811199, chunks 20894 .. 20924
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l674 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0674" 390070272 12582912

end CS31aData.N13
