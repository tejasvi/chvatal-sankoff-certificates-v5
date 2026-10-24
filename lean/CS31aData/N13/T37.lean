import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 37 = cert_data/n13/h13c.tab.part0037, entries 2948595712 .. 3028287487, chunks 703 .. 721
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t37 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0037" 398458880 20971520

end CS31aData.N13
