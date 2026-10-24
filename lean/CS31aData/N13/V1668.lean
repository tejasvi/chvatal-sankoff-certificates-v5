import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1668 = cert_data/n13/h13c.vec.part1668, entries 160910278656 .. 161006747647, chunks 38364 .. 38386
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1668 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1668" 385875968 16777216

end CS31aData.N13
