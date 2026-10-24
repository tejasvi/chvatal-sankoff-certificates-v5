import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 911 = cert_data/n13/h13c.low.part0911, entries 118451339264 .. 118581362687, chunks 28241 .. 28271
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l911 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0911" 390070272 12582912

end CS31aData.N13
