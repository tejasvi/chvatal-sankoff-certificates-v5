import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 32 = cert_data/n13/h13c.tab.part0032, entries 2550136832 .. 2629828607, chunks 608 .. 626
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t32 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0032" 398458880 20971520

end CS31aData.N13
