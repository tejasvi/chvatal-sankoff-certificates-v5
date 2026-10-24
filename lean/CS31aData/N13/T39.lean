import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 39 = cert_data/n13/h13c.tab.part0039, entries 3107979264 .. 3187671039, chunks 741 .. 759
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t39 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0039" 398458880 20971520

end CS31aData.N13
