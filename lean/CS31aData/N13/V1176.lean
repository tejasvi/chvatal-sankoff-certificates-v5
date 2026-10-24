import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1176 = cert_data/n13/h13c.vec.part1176, entries 113447534592 .. 113544003583, chunks 27048 .. 27070
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1176 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1176" 385875968 16777216

end CS31aData.N13
