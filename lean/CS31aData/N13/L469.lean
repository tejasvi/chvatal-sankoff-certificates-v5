import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 469 = cert_data/n13/h13c.low.part0469, entries 60980985856 .. 61111009279, chunks 14539 .. 14569
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l469 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0469" 390070272 12582912

end CS31aData.N13
