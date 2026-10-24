import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 15 = cert_data/n13/h13c.tab.part0015, entries 1195376640 .. 1275068415, chunks 285 .. 303
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t15 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0015" 398458880 20971520

end CS31aData.N13
