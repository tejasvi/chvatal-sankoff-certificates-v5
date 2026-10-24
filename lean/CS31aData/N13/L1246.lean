import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1246 = cert_data/n13/h13c.low.part1246, entries 162009186304 .. 162139209727, chunks 38626 .. 38656
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1246 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1246" 390070272 12582912

end CS31aData.N13
