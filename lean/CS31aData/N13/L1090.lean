import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1090 = cert_data/n13/h13c.low.part1090, entries 141725532160 .. 141855555583, chunks 33790 .. 33820
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1090 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1090" 390070272 12582912

end CS31aData.N13
