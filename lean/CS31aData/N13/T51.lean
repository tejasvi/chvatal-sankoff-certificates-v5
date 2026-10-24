import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 51 = cert_data/n13/h13c.tab.part0051, entries 4064280576 .. 4143972351, chunks 969 .. 987
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t51 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0051" 398458880 20971520

end CS31aData.N13
