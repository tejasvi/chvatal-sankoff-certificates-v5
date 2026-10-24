import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 847 = cert_data/n13/h13c.vec.part0847, entries 81709236224 .. 81805705215, chunks 19481 .. 19503
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v847 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0847" 385875968 16777216

end CS31aData.N13
