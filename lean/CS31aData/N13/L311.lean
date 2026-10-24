import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 311 = cert_data/n13/h13c.low.part0311, entries 40437284864 .. 40567308287, chunks 9641 .. 9671
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l311 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0311" 390070272 12582912

end CS31aData.N13
