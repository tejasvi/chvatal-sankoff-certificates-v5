import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 195 = cert_data/n13/h13c.low.part0195, entries 25354567680 .. 25484591103, chunks 6045 .. 6075
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l195 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0195" 390070272 12582912

end CS31aData.N13
