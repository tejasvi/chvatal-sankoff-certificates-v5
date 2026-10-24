import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 561 = cert_data/n13/h13c.low.part0561, entries 72943140864 .. 73073164287, chunks 17391 .. 17421
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l561 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0561" 390070272 12582912

end CS31aData.N13
