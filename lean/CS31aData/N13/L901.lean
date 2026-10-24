import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 901 = cert_data/n13/h13c.low.part0901, entries 117151105024 .. 117281128447, chunks 27931 .. 27961
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l901 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0901" 390070272 12582912

end CS31aData.N13
