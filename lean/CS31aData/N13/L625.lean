import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 625 = cert_data/n13/h13c.low.part0625, entries 81264640000 .. 81394663423, chunks 19375 .. 19405
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l625 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0625" 390070272 12582912

end CS31aData.N13
