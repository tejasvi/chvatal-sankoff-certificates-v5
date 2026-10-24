import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 40 = cert_data/n13/h13c.tab.part0040, entries 3187671040 .. 3267362815, chunks 760 .. 778
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t40 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0040" 398458880 20971520

end CS31aData.N13
