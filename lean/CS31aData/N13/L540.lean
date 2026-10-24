import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 540 = cert_data/n13/h13c.low.part0540, entries 70212648960 .. 70342672383, chunks 16740 .. 16770
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l540 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0540" 390070272 12582912

end CS31aData.N13
