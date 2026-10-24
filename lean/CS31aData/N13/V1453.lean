import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1453 = cert_data/n13/h13c.vec.part1453, entries 140169445376 .. 140265914367, chunks 33419 .. 33441
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1453 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1453" 385875968 16777216

end CS31aData.N13
