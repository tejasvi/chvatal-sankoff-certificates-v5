import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 45 = cert_data/n13/h13c.tab.part0045, entries 3586129920 .. 3665821695, chunks 855 .. 873
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t45 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0045" 398458880 20971520

end CS31aData.N13
