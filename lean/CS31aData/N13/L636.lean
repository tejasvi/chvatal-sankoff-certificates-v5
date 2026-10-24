import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 636 = cert_data/n13/h13c.low.part0636, entries 82694897664 .. 82824921087, chunks 19716 .. 19746
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l636 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0636" 390070272 12582912

end CS31aData.N13
