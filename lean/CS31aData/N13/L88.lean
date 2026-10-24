import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 88 = cert_data/n13/h13c.low.part0088, entries 11442061312 .. 11572084735, chunks 2728 .. 2758
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l88 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0088" 390070272 12582912

end CS31aData.N13
