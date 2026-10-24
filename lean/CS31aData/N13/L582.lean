import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 582 = cert_data/n13/h13c.low.part0582, entries 75673632768 .. 75803656191, chunks 18042 .. 18072
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l582 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0582" 390070272 12582912

end CS31aData.N13
