import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 162 = cert_data/n13/h13c.low.part0162, entries 21063794688 .. 21193818111, chunks 5022 .. 5052
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l162 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0162" 390070272 12582912

end CS31aData.N13
