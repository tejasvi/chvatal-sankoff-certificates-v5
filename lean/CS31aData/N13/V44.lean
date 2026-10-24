import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 44 = cert_data/n13/h13c.vec.part0044, entries 4244635648 .. 4341104639, chunks 1012 .. 1034
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v44 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0044" 385875968 16777216

end CS31aData.N13
