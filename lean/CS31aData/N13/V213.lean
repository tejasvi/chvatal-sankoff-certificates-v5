import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 213 = cert_data/n13/h13c.vec.part0213, entries 20547895296 .. 20644364287, chunks 4899 .. 4921
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v213 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0213" 385875968 16777216

end CS31aData.N13
