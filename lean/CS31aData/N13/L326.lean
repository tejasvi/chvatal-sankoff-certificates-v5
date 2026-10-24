import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 326 = cert_data/n13/h13c.low.part0326, entries 42387636224 .. 42517659647, chunks 10106 .. 10136
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l326 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0326" 390070272 12582912

end CS31aData.N13
