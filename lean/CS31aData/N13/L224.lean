import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 224 = cert_data/n13/h13c.low.part0224, entries 29125246976 .. 29255270399, chunks 6944 .. 6974
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l224 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0224" 390070272 12582912

end CS31aData.N13
