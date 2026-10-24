import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 778 = cert_data/n13/h13c.low.part0778, entries 101158223872 .. 101288247295, chunks 24118 .. 24148
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l778 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0778" 390070272 12582912

end CS31aData.N13
