import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 405 = cert_data/n13/h13c.low.part0405, entries 52659486720 .. 52789510143, chunks 12555 .. 12585
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l405 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0405" 390070272 12582912

end CS31aData.N13
