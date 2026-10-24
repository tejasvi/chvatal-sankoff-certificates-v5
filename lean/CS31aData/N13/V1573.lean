import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1573 = cert_data/n13/h13c.vec.part1573, entries 151745724416 .. 151842193407, chunks 36179 .. 36201
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1573 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1573" 385875968 16777216

end CS31aData.N13
