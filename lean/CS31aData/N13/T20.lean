import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 20 = cert_data/n13/h13c.tab.part0020, entries 1593835520 .. 1673527295, chunks 380 .. 398
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t20 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0020" 398458880 20971520

end CS31aData.N13
