import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 498 = cert_data/n13/h13c.low.part0498, entries 64751665152 .. 64881688575, chunks 15438 .. 15468
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l498 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0498" 390070272 12582912

end CS31aData.N13
