import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 574 = cert_data/n13/h13c.low.part0574, entries 74633445376 .. 74763468799, chunks 17794 .. 17824
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l574 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0574" 390070272 12582912

end CS31aData.N13
