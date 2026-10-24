import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 303 = cert_data/n13/h13c.low.part0303, entries 39397097472 .. 39527120895, chunks 9393 .. 9423
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l303 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0303" 390070272 12582912

end CS31aData.N13
