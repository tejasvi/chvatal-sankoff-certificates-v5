import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 406 = cert_data/n13/h13c.low.part0406, entries 52789510144 .. 52919533567, chunks 12586 .. 12616
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l406 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0406" 390070272 12582912

end CS31aData.N13
