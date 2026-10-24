import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 50 = cert_data/n13/h13c.low.part0050, entries 6501171200 .. 6631194623, chunks 1550 .. 1580
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l50 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0050" 390070272 12582912

end CS31aData.N13
