import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 846 = cert_data/n13/h13c.low.part0846, entries 109999816704 .. 110129840127, chunks 26226 .. 26256
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l846 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0846" 390070272 12582912

end CS31aData.N13
