import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 48 = cert_data/n13/h13c.tab.part0048, entries 3825205248 .. 3904897023, chunks 912 .. 930
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t48 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0048" 398458880 20971520

end CS31aData.N13
