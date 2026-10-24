import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 652 = cert_data/n13/h13c.low.part0652, entries 84775272448 .. 84905295871, chunks 20212 .. 20242
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l652 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0652" 390070272 12582912

end CS31aData.N13
