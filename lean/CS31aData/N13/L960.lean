import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 960 = cert_data/n13/h13c.low.part0960, entries 124822487040 .. 124952510463, chunks 29760 .. 29790
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l960 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0960" 390070272 12582912

end CS31aData.N13
