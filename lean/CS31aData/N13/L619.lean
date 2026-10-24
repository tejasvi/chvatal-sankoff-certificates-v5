import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 619 = cert_data/n13/h13c.low.part0619, entries 80484499456 .. 80614522879, chunks 19189 .. 19219
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l619 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0619" 390070272 12582912

end CS31aData.N13
