import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 845 = cert_data/n13/h13c.low.part0845, entries 109869793280 .. 109999816703, chunks 26195 .. 26225
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l845 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0845" 390070272 12582912

end CS31aData.N13
