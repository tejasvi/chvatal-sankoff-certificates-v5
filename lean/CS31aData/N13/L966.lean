import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 966 = cert_data/n13/h13c.low.part0966, entries 125602627584 .. 125732651007, chunks 29946 .. 29976
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l966 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0966" 390070272 12582912

end CS31aData.N13
