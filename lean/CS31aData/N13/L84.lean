import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 84 = cert_data/n13/h13c.low.part0084, entries 10921967616 .. 11051991039, chunks 2604 .. 2634
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l84 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0084" 390070272 12582912

end CS31aData.N13
