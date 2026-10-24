import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 24 = cert_data/n13/h13c.tab.part0024, entries 1912602624 .. 1992294399, chunks 456 .. 474
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t24 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0024" 398458880 20971520

end CS31aData.N13
