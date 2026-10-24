import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 662 = cert_data/n13/h13c.low.part0662, entries 86075506688 .. 86205530111, chunks 20522 .. 20552
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l662 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0662" 390070272 12582912

end CS31aData.N13
