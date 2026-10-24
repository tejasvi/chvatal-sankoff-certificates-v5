import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 413 = cert_data/n13/h13c.low.part0413, entries 53699674112 .. 53829697535, chunks 12803 .. 12833
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l413 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0413" 390070272 12582912

end CS31aData.N13
