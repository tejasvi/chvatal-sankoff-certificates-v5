import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 447 = cert_data/n13/h13c.low.part0447, entries 58120470528 .. 58250493951, chunks 13857 .. 13887
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l447 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0447" 390070272 12582912

end CS31aData.N13
