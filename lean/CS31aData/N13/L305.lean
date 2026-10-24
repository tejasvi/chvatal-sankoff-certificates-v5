import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 305 = cert_data/n13/h13c.low.part0305, entries 39657144320 .. 39787167743, chunks 9455 .. 9485
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l305 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0305" 390070272 12582912

end CS31aData.N13
