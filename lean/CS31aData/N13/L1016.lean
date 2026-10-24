import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1016 = cert_data/n13/h13c.low.part1016, entries 132103798784 .. 132233822207, chunks 31496 .. 31526
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1016 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1016" 390070272 12582912

end CS31aData.N13
