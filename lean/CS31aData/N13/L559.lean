import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 559 = cert_data/n13/h13c.low.part0559, entries 72683094016 .. 72813117439, chunks 17329 .. 17359
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l559 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0559" 390070272 12582912

end CS31aData.N13
