import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 661 = cert_data/n13/h13c.low.part0661, entries 85945483264 .. 86075506687, chunks 20491 .. 20521
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l661 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0661" 390070272 12582912

end CS31aData.N13
