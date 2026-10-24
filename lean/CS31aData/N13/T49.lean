import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 49 = cert_data/n13/h13c.tab.part0049, entries 3904897024 .. 3984588799, chunks 931 .. 949
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t49 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0049" 398458880 20971520

end CS31aData.N13
