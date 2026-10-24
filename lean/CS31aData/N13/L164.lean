import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 164 = cert_data/n13/h13c.low.part0164, entries 21323841536 .. 21453864959, chunks 5084 .. 5114
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l164 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0164" 390070272 12582912

end CS31aData.N13
