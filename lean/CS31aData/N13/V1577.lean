import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1577 = cert_data/n13/h13c.vec.part1577, entries 152131600384 .. 152228069375, chunks 36271 .. 36293
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1577 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1577" 385875968 16777216

end CS31aData.N13
