import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1315 = cert_data/n13/h13c.vec.part1315, entries 126856724480 .. 126953193471, chunks 30245 .. 30267
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1315 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1315" 385875968 16777216

end CS31aData.N13
