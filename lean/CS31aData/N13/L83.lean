import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 83 = cert_data/n13/h13c.low.part0083, entries 10791944192 .. 10921967615, chunks 2573 .. 2603
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l83 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0083" 390070272 12582912

end CS31aData.N13
