import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 290 = cert_data/n13/h13c.low.part0290, entries 37706792960 .. 37836816383, chunks 8990 .. 9020
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l290 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0290" 390070272 12582912

end CS31aData.N13
