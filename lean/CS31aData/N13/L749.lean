import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 749 = cert_data/n13/h13c.low.part0749, entries 97387544576 .. 97517567999, chunks 23219 .. 23249
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l749 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0749" 390070272 12582912

end CS31aData.N13
