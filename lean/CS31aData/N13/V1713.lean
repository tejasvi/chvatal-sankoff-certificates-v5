import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1713 = cert_data/n13/h13c.vec.part1713, entries 165251383296 .. 165347852287, chunks 39399 .. 39421
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1713 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1713" 385875968 16777216

end CS31aData.N13
