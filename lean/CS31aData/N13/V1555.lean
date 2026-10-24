import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1555 = cert_data/n13/h13c.vec.part1555, entries 150009282560 .. 150105751551, chunks 35765 .. 35787
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1555 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1555" 385875968 16777216

end CS31aData.N13
