import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 368 = cert_data/n13/h13c.low.part0368, entries 47848620032 .. 47978643455, chunks 11408 .. 11438
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l368 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0368" 390070272 12582912

end CS31aData.N13
