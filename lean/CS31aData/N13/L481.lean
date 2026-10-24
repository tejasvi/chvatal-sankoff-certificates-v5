import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 481 = cert_data/n13/h13c.low.part0481, entries 62541266944 .. 62671290367, chunks 14911 .. 14941
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l481 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0481" 390070272 12582912

end CS31aData.N13
