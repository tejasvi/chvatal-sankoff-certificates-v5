import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 379 = cert_data/n13/h13c.low.part0379, entries 49278877696 .. 49408901119, chunks 11749 .. 11779
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l379 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0379" 390070272 12582912

end CS31aData.N13
