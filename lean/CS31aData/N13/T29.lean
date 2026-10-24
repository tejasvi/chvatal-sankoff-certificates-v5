import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 29 = cert_data/n13/h13c.tab.part0029, entries 2311061504 .. 2390753279, chunks 551 .. 569
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t29 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0029" 398458880 20971520

end CS31aData.N13
