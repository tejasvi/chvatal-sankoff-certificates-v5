import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 672 = cert_data/n13/h13c.low.part0672, entries 87375740928 .. 87505764351, chunks 20832 .. 20862
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l672 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0672" 390070272 12582912

end CS31aData.N13
