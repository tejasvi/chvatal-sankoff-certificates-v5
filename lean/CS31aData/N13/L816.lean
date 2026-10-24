import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 816 = cert_data/n13/h13c.low.part0816, entries 106099113984 .. 106229137407, chunks 25296 .. 25326
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l816 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0816" 390070272 12582912

end CS31aData.N13
