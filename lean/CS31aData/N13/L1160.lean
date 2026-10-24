import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1160 = cert_data/n13/h13c.low.part1160, entries 150827171840 .. 150957195263, chunks 35960 .. 35990
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1160 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1160" 390070272 12582912

end CS31aData.N13
