import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1072 = cert_data/n13/h13c.low.part1072, entries 139385110528 .. 139515133951, chunks 33232 .. 33262
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1072 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1072" 390070272 12582912

end CS31aData.N13
