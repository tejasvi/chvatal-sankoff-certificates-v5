import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 676 = cert_data/n13/h13c.low.part0676, entries 87895834624 .. 88025858047, chunks 20956 .. 20986
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l676 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0676" 390070272 12582912

end CS31aData.N13
