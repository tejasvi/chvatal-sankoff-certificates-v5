import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 725 = cert_data/n13/h13c.low.part0725, entries 94266982400 .. 94397005823, chunks 22475 .. 22505
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l725 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0725" 390070272 12582912

end CS31aData.N13
