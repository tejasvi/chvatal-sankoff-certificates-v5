import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 824 = cert_data/n13/h13c.low.part0824, entries 107139301376 .. 107269324799, chunks 25544 .. 25574
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l824 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0824" 390070272 12582912

end CS31aData.N13
