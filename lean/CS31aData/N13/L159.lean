import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 159 = cert_data/n13/h13c.low.part0159, entries 20673724416 .. 20803747839, chunks 4929 .. 4959
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l159 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0159" 390070272 12582912

end CS31aData.N13
