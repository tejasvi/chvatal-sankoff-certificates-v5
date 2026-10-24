import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 275 = cert_data/n13/h13c.low.part0275, entries 35756441600 .. 35886465023, chunks 8525 .. 8555
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l275 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0275" 390070272 12582912

end CS31aData.N13
