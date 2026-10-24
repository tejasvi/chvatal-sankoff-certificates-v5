import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1256 = cert_data/n13/h13c.low.part1256, entries 163309420544 .. 163439443967, chunks 38936 .. 38966
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1256 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1256" 390070272 12582912

end CS31aData.N13
