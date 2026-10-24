import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 697 = cert_data/n13/h13c.low.part0697, entries 90626326528 .. 90756349951, chunks 21607 .. 21637
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l697 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0697" 390070272 12582912

end CS31aData.N13
