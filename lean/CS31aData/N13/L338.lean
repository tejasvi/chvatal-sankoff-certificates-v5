import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 338 = cert_data/n13/h13c.low.part0338, entries 43947917312 .. 44077940735, chunks 10478 .. 10508
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l338 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0338" 390070272 12582912

end CS31aData.N13
