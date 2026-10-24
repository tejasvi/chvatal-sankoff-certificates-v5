import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 0 = cert_data/n13/h13c.low.part0000, entries 0 .. 130023423, chunks 0 .. 30
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l0 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0000" 390070272 12582912

end CS31aData.N13
