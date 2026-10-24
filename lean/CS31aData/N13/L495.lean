import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 495 = cert_data/n13/h13c.low.part0495, entries 64361594880 .. 64491618303, chunks 15345 .. 15375
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l495 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0495" 390070272 12582912

end CS31aData.N13
