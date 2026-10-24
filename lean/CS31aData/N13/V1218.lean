import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1218 = cert_data/n13/h13c.vec.part1218, entries 117499232256 .. 117595701247, chunks 28014 .. 28036
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1218 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1218" 385875968 16777216

end CS31aData.N13
