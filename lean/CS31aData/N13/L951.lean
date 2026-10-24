import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 951 = cert_data/n13/h13c.low.part0951, entries 123652276224 .. 123782299647, chunks 29481 .. 29511
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l951 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0951" 390070272 12582912

end CS31aData.N13
