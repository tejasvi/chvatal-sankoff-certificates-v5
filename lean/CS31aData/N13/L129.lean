import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 129 = cert_data/n13/h13c.low.part0129, entries 16773021696 .. 16903045119, chunks 3999 .. 4029
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l129 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0129" 390070272 12582912

end CS31aData.N13
