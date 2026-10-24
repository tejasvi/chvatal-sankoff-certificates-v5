import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 525 = cert_data/n13/h13c.low.part0525, entries 68262297600 .. 68392321023, chunks 16275 .. 16305
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l525 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0525" 390070272 12582912

end CS31aData.N13
