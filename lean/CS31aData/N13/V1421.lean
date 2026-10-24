import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1421 = cert_data/n13/h13c.vec.part1421, entries 137082437632 .. 137178906623, chunks 32683 .. 32705
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1421 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1421" 385875968 16777216

end CS31aData.N13
