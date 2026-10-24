import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 32 = cert_data/n13/h13c.low.part0032, entries 4160749568 .. 4290772991, chunks 992 .. 1022
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l32 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0032" 390070272 12582912

end CS31aData.N13
