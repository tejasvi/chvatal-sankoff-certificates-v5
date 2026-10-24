import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 554 = cert_data/n13/h13c.vec.part0554, entries 53443821568 .. 53540290559, chunks 12742 .. 12764
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v554 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0554" 385875968 16777216

end CS31aData.N13
