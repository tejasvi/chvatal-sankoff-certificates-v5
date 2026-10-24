import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 918 = cert_data/n13/h13c.low.part0918, entries 119361503232 .. 119491526655, chunks 28458 .. 28488
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l918 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0918" 390070272 12582912

end CS31aData.N13
