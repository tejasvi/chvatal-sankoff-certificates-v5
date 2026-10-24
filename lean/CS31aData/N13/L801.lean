import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 801 = cert_data/n13/h13c.low.part0801, entries 104148762624 .. 104278786047, chunks 24831 .. 24861
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l801 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0801" 390070272 12582912

end CS31aData.N13
