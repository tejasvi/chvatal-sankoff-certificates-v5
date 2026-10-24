import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 16 = cert_data/n13/h13c.tab.part0016, entries 1275068416 .. 1354760191, chunks 304 .. 322
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t16 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0016" 398458880 20971520

end CS31aData.N13
