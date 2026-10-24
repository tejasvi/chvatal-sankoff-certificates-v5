import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 140 = cert_data/n13/h13c.low.part0140, entries 18203279360 .. 18333302783, chunks 4340 .. 4370
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l140 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0140" 390070272 12582912

end CS31aData.N13
