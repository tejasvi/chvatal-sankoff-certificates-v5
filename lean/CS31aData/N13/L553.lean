import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 553 = cert_data/n13/h13c.low.part0553, entries 71902953472 .. 72032976895, chunks 17143 .. 17173
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l553 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0553" 390070272 12582912

end CS31aData.N13
