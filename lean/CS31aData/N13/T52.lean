import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 52 = cert_data/n13/h13c.tab.part0052, entries 4143972352 .. 4223664127, chunks 988 .. 1006
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t52 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0052" 398458880 20971520

end CS31aData.N13
