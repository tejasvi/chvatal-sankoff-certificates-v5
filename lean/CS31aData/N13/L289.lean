import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 289 = cert_data/n13/h13c.low.part0289, entries 37576769536 .. 37706792959, chunks 8959 .. 8989
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l289 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0289" 390070272 12582912

end CS31aData.N13
