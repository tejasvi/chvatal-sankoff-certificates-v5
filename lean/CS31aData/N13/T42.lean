import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 42 = cert_data/n13/h13c.tab.part0042, entries 3347054592 .. 3426746367, chunks 798 .. 816
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t42 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0042" 398458880 20971520

end CS31aData.N13
