import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1303 = cert_data/n13/h13c.vec.part1303, entries 125699096576 .. 125795565567, chunks 29969 .. 29991
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1303 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1303" 385875968 16777216

end CS31aData.N13
