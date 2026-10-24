import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 994 = cert_data/n13/h13c.vec.part0994, entries 95890178048 .. 95986647039, chunks 22862 .. 22884
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v994 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0994" 385875968 16777216

end CS31aData.N13
