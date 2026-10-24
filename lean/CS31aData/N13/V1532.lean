import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1532 = cert_data/n13/h13c.vec.part1532, entries 147790495744 .. 147886964735, chunks 35236 .. 35258
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1532 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1532" 385875968 16777216

end CS31aData.N13
