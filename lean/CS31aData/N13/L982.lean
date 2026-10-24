import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 982 = cert_data/n13/h13c.low.part0982, entries 127683002368 .. 127813025791, chunks 30442 .. 30472
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l982 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0982" 390070272 12582912

end CS31aData.N13
