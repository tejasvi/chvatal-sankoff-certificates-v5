import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 740 = cert_data/n13/h13c.low.part0740, entries 96217333760 .. 96347357183, chunks 22940 .. 22970
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l740 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0740" 390070272 12582912

end CS31aData.N13
