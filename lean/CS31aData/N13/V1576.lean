import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1576 = cert_data/n13/h13c.vec.part1576, entries 152035131392 .. 152131600383, chunks 36248 .. 36270
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1576 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1576" 385875968 16777216

end CS31aData.N13
