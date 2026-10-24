import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 533 = cert_data/n13/h13c.low.part0533, entries 69302484992 .. 69432508415, chunks 16523 .. 16553
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l533 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0533" 390070272 12582912

end CS31aData.N13
