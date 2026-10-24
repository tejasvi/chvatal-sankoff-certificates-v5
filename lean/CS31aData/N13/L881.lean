import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 881 = cert_data/n13/h13c.low.part0881, entries 114550636544 .. 114680659967, chunks 27311 .. 27341
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l881 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0881" 390070272 12582912

end CS31aData.N13
