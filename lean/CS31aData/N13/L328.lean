import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 328 = cert_data/n13/h13c.low.part0328, entries 42647683072 .. 42777706495, chunks 10168 .. 10198
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l328 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0328" 390070272 12582912

end CS31aData.N13
