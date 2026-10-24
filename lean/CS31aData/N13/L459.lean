import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 459 = cert_data/n13/h13c.low.part0459, entries 59680751616 .. 59810775039, chunks 14229 .. 14259
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l459 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0459" 390070272 12582912

end CS31aData.N13
