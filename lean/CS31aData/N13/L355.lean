import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 355 = cert_data/n13/h13c.low.part0355, entries 46158315520 .. 46288338943, chunks 11005 .. 11035
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l355 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0355" 390070272 12582912

end CS31aData.N13
