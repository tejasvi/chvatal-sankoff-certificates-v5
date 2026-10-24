import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 883 = cert_data/n13/h13c.low.part0883, entries 114810683392 .. 114940706815, chunks 27373 .. 27403
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l883 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0883" 390070272 12582912

end CS31aData.N13
