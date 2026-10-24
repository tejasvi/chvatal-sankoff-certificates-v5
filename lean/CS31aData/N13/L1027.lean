import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1027 = cert_data/n13/h13c.low.part1027, entries 133534056448 .. 133664079871, chunks 31837 .. 31867
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1027 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1027" 390070272 12582912

end CS31aData.N13
