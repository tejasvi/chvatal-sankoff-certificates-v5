import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1035 = cert_data/n13/h13c.low.part1035, entries 134574243840 .. 134704267263, chunks 32085 .. 32115
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1035 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1035" 390070272 12582912

end CS31aData.N13
