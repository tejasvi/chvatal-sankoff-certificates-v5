import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 465 = cert_data/n13/h13c.low.part0465, entries 60460892160 .. 60590915583, chunks 14415 .. 14445
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l465 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0465" 390070272 12582912

end CS31aData.N13
