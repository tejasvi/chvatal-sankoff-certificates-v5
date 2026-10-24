import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 200 = cert_data/n13/h13c.low.part0200, entries 26004684800 .. 26134708223, chunks 6200 .. 6230
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l200 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0200" 390070272 12582912

end CS31aData.N13
