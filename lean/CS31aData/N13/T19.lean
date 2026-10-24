import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 19 = cert_data/n13/h13c.tab.part0019, entries 1514143744 .. 1593835519, chunks 361 .. 379
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t19 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0019" 398458880 20971520

end CS31aData.N13
