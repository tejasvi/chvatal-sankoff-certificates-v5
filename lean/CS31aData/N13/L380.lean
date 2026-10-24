import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 380 = cert_data/n13/h13c.low.part0380, entries 49408901120 .. 49538924543, chunks 11780 .. 11810
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l380 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0380" 390070272 12582912

end CS31aData.N13
