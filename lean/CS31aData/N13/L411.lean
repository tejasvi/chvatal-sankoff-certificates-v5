import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 411 = cert_data/n13/h13c.low.part0411, entries 53439627264 .. 53569650687, chunks 12741 .. 12771
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l411 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0411" 390070272 12582912

end CS31aData.N13
