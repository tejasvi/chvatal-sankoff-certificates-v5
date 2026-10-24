import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 805 = cert_data/n13/h13c.low.part0805, entries 104668856320 .. 104798879743, chunks 24955 .. 24985
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l805 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0805" 390070272 12582912

end CS31aData.N13
