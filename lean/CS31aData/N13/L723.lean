import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 723 = cert_data/n13/h13c.low.part0723, entries 94006935552 .. 94136958975, chunks 22413 .. 22443
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l723 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0723" 390070272 12582912

end CS31aData.N13
