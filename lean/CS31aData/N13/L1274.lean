import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1274 = cert_data/n13/h13c.low.part1274, entries 165649842176 .. 165695219468, chunks 39494 .. 39504
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1274 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1274" 136131879 12582912

end CS31aData.N13
