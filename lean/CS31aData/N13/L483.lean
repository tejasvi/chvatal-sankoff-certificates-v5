import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 483 = cert_data/n13/h13c.low.part0483, entries 62801313792 .. 62931337215, chunks 14973 .. 15003
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l483 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0483" 390070272 12582912

end CS31aData.N13
