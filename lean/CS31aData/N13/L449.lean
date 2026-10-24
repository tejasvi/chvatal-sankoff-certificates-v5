import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 449 = cert_data/n13/h13c.low.part0449, entries 58380517376 .. 58510540799, chunks 13919 .. 13949
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l449 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0449" 390070272 12582912

end CS31aData.N13
