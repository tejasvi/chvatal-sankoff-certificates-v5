import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1501 = cert_data/n13/h13c.vec.part1501, entries 144799956992 .. 144896425983, chunks 34523 .. 34545
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1501 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1501" 385875968 16777216

end CS31aData.N13
