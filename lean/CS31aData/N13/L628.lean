import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 628 = cert_data/n13/h13c.low.part0628, entries 81654710272 .. 81784733695, chunks 19468 .. 19498
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l628 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0628" 390070272 12582912

end CS31aData.N13
