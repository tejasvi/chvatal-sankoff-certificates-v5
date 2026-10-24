import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 47 = cert_data/n13/h13c.tab.part0047, entries 3745513472 .. 3825205247, chunks 893 .. 911
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t47 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0047" 398458880 20971520

end CS31aData.N13
