import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 226 = cert_data/n13/h13c.low.part0226, entries 29385293824 .. 29515317247, chunks 7006 .. 7036
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l226 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0226" 390070272 12582912

end CS31aData.N13
