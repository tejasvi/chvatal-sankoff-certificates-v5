import CS31aData.Elab

/-! N13 data, tab (bucket table, 5 bytes LE per entry): part 46 = cert_data/n13/h13c.tab.part0046, entries 3665821696 .. 3745513471, chunks 874 .. 892
of 2^22 entries (20971520 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def t46 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.tab.part0046" 398458880 20971520

end CS31aData.N13
