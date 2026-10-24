import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1206 = cert_data/n13/h13c.vec.part1206, entries 116341604352 .. 116438073343, chunks 27738 .. 27760
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1206 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1206" 385875968 16777216

end CS31aData.N13
