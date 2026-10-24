import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 53 = cert_data/n13/h13c.tab.part0053, entries 4223664128 .. 4294967296, chunks 1007 .. 1024
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t53 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0053" 356515845 20971520

end CS31aData.N13
