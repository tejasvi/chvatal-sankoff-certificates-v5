import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 848 = cert_data/n13/h13c.low.part0848, entries 110259863552 .. 110389886975, chunks 26288 .. 26318
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l848 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0848" 390070272 12582912

end CS31aData.N13
