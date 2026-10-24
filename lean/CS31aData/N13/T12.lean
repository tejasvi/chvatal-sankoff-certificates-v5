import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 12 = cert_data/n13/h13c.tab.part0012, entries 956301312 .. 1035993087, chunks 228 .. 246
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t12 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0012" 398458880 20971520

end CS31aData.N13
