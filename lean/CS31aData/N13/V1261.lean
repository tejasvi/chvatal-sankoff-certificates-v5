import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1261 = cert_data/n13/h13c.vec.part1261, entries 121647398912 .. 121743867903, chunks 29003 .. 29025
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1261 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1261" 385875968 16777216

end CS31aData.N13
