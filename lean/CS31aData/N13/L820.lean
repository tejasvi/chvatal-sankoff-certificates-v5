import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 820 = cert_data/n13/h13c.low.part0820, entries 106619207680 .. 106749231103, chunks 25420 .. 25450
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l820 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0820" 390070272 12582912

end CS31aData.N13
