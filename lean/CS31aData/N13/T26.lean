import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 26 = cert_data/n13/h13c.tab.part0026, entries 2071986176 .. 2151677951, chunks 494 .. 512
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t26 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0026" 398458880 20971520

end CS31aData.N13
