import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1063 = cert_data/n13/h13c.low.part1063, entries 138214899712 .. 138344923135, chunks 32953 .. 32983
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1063 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1063" 390070272 12582912

end CS31aData.N13
