import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1230 = cert_data/n13/h13c.low.part1230, entries 159928811520 .. 160058834943, chunks 38130 .. 38160
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1230 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1230" 390070272 12582912

end CS31aData.N13
