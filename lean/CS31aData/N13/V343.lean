import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 343 = cert_data/n13/h13c.vec.part0343, entries 33088864256 .. 33185333247, chunks 7889 .. 7911
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v343 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0343" 385875968 16777216

end CS31aData.N13
