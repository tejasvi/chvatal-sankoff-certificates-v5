import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1191 = cert_data/n13/h13c.low.part1191, entries 154857897984 .. 154987921407, chunks 36921 .. 36951
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1191 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1191" 390070272 12582912

end CS31aData.N13
