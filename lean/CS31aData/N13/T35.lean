import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 35 = cert_data/n13/h13c.tab.part0035, entries 2789212160 .. 2868903935, chunks 665 .. 683
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t35 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0035" 398458880 20971520

end CS31aData.N13
