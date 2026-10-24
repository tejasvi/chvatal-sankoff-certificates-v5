import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 33 = cert_data/n13/h13c.tab.part0033, entries 2629828608 .. 2709520383, chunks 627 .. 645
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t33 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0033" 398458880 20971520

end CS31aData.N13
