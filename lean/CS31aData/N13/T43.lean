import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 43 = cert_data/n13/h13c.tab.part0043, entries 3426746368 .. 3506438143, chunks 817 .. 835
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t43 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0043" 398458880 20971520

end CS31aData.N13
