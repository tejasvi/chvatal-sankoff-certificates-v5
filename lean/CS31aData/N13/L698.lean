import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 698 = cert_data/n13/h13c.low.part0698, entries 90756349952 .. 90886373375, chunks 21638 .. 21668
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l698 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0698" 390070272 12582912

end CS31aData.N13
