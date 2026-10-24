import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1202 = cert_data/n13/h13c.low.part1202, entries 156288155648 .. 156418179071, chunks 37262 .. 37292
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1202 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1202" 390070272 12582912

end CS31aData.N13
