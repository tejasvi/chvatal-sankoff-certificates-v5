import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 633 = cert_data/n13/h13c.low.part0633, entries 82304827392 .. 82434850815, chunks 19623 .. 19653
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l633 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0633" 390070272 12582912

end CS31aData.N13
