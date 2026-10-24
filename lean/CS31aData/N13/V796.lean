import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 796 = cert_data/n13/h13c.vec.part0796, entries 76789317632 .. 76885786623, chunks 18308 .. 18330
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v796 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0796" 385875968 16777216

end CS31aData.N13
