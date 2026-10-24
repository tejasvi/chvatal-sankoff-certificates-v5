import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 565 = cert_data/n13/h13c.low.part0565, entries 73463234560 .. 73593257983, chunks 17515 .. 17545
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l565 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0565" 390070272 12582912

end CS31aData.N13
