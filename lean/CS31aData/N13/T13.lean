import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 13 = cert_data/n13/h13c.tab.part0013, entries 1035993088 .. 1115684863, chunks 247 .. 265
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t13 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0013" 398458880 20971520

end CS31aData.N13
