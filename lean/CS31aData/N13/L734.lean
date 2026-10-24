import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 734 = cert_data/n13/h13c.low.part0734, entries 95437193216 .. 95567216639, chunks 22754 .. 22784
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l734 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0734" 390070272 12582912

end CS31aData.N13
