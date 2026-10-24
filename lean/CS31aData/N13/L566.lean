import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 566 = cert_data/n13/h13c.low.part0566, entries 73593257984 .. 73723281407, chunks 17546 .. 17576
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l566 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0566" 390070272 12582912

end CS31aData.N13
