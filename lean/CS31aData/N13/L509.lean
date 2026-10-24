import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 509 = cert_data/n13/h13c.low.part0509, entries 66181922816 .. 66311946239, chunks 15779 .. 15809
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l509 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0509" 390070272 12582912

end CS31aData.N13
