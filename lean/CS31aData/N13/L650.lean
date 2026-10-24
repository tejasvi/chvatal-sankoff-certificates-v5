import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 650 = cert_data/n13/h13c.low.part0650, entries 84515225600 .. 84645249023, chunks 20150 .. 20180
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l650 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0650" 390070272 12582912

end CS31aData.N13
