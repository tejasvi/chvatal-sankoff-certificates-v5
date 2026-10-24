import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 259 = cert_data/n13/h13c.low.part0259, entries 33676066816 .. 33806090239, chunks 8029 .. 8059
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l259 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0259" 390070272 12582912

end CS31aData.N13
