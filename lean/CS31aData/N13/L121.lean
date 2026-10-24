import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 121 = cert_data/n13/h13c.low.part0121, entries 15732834304 .. 15862857727, chunks 3751 .. 3781
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l121 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0121" 390070272 12582912

end CS31aData.N13
