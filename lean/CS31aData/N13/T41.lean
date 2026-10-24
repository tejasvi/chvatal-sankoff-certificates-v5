import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 41 = cert_data/n13/h13c.tab.part0041, entries 3267362816 .. 3347054591, chunks 779 .. 797
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t41 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0041" 398458880 20971520

end CS31aData.N13
