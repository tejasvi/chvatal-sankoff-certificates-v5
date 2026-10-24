import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 527 = cert_data/n13/h13c.low.part0527, entries 68522344448 .. 68652367871, chunks 16337 .. 16367
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l527 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0527" 390070272 12582912

end CS31aData.N13
