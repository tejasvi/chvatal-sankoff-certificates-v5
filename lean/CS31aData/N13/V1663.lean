import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1663 = cert_data/n13/h13c.vec.part1663, entries 160427933696 .. 160524402687, chunks 38249 .. 38271
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1663 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1663" 385875968 16777216

end CS31aData.N13
