import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 192 = cert_data/n13/h13c.low.part0192, entries 24964497408 .. 25094520831, chunks 5952 .. 5982
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l192 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0192" 390070272 12582912

end CS31aData.N13
