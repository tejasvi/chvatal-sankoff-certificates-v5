import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 23 = cert_data/n13/h13c.tab.part0023, entries 1832910848 .. 1912602623, chunks 437 .. 455
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t23 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0023" 398458880 20971520

end CS31aData.N13
