import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 683 = cert_data/n13/h13c.low.part0683, entries 88805998592 .. 88936022015, chunks 21173 .. 21203
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l683 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0683" 390070272 12582912

end CS31aData.N13
