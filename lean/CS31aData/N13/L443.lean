import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 443 = cert_data/n13/h13c.low.part0443, entries 57600376832 .. 57730400255, chunks 13733 .. 13763
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l443 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0443" 390070272 12582912

end CS31aData.N13
