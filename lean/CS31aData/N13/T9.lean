import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 9 = cert_data/n13/h13c.tab.part0009, entries 717225984 .. 796917759, chunks 171 .. 189
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t9 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0009" 398458880 20971520

end CS31aData.N13
