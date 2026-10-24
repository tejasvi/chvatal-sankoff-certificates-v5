import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 729 = cert_data/n13/h13c.low.part0729, entries 94787076096 .. 94917099519, chunks 22599 .. 22629
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l729 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0729" 390070272 12582912

end CS31aData.N13
