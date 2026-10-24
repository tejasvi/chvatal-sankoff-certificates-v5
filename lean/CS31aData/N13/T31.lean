import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 31 = cert_data/n13/h13c.tab.part0031, entries 2470445056 .. 2550136831, chunks 589 .. 607
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t31 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0031" 398458880 20971520

end CS31aData.N13
