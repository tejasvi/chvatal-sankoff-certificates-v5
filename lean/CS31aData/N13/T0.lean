import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 0 = cert_data/n13/h13c.tab.part0000, entries 0 .. 79691775, chunks 0 .. 18
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t0 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0000" 398458880 20971520

end CS31aData.N13
