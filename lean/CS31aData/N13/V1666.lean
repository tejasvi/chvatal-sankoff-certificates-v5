import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1666 = cert_data/n13/h13c.vec.part1666, entries 160717340672 .. 160813809663, chunks 38318 .. 38340
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1666 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1666" 385875968 16777216

end CS31aData.N13
